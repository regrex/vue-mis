<template>
  <div class="layout-content-wrp">
    <div class="layout-content-main">
      <template>
        <Select v-model="model1" style="width:200px">
            <Option v-for="item in firstStageList" :value="item.value" :key="item">{{ item.label }}</Option>
        </Select>
      </template>
      <Input v-model="value13" style="width:400px;" class="search-wrap">
        <Select v-model="select3" slot="prepend" style="width: 80px">
            <Option value="day">源名称</Option>
        </Select>
        <Button slot="append" icon="ios-search">搜索</Button>
      </Input>
      <div class="table-btn-wrp">
        <Button type="primary" icon="arrow-expand">整体预览</Button> 
        <!-- <Icon type="arrow-expand"></Icon> -->
        <Button type="primary" icon="ios-plus-empty">新增</Button>
        <Button type="warning">删除</Button>
      </div>
      <Table :columns="columns1" :data="data1" class="table-content"></Table>
      <div class="page-wrap">
        <Page :total="total" :page-size="pageSize" :current="1" @on-change="changePage"></Page>
      </div>
    </div>
  </div>
</template>

<script>
import TableRow from './TableRow.vue';
export default {
  name: 'article',
  components: {
    TableRow
  },
  data () {
    return {
      value11: '',
      value12: '',
      value13: '',
      select1: 'http',
      select2: 'com',
      select3: 'day',
      columns1: [
        {
          type: 'selection',
          width: 60,
          align: 'center'
        },
        {
          title: '源名称',
          key: 'name'
        },
        {
          title: '源类型',
          key: 'type'
        },
        {
          title: '权重',
          key: 'weight'
        },
        {
          title: '状态',
          key: 'status',
          render: (h, params) => {
            const row = params.row;
            const text = row.status === 0 ? '未上线' : '已上线';
            // return h('Tag', text);
            return text;
          }
        },
        {
          title: '操作',
          key: 'operate',
          width: 220,
          render: (h, params) => {
            const row = params.row;
            const type = row.type;
            const status = row.status;
            console.log('this-opertae', this);
            if(type == '百家号') {
              // 未上线
              if(status == 0 ) {
                // return '上线 删除';
                return h('div', [
                  h('Button', {
                    props: {
                        type: 'primary',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.show(params.index)
                          console.log('百家号-0-上线！');
                        }
                    }
                  }, '上线'),
                  h('Button', {
                    props: {
                        type: 'error',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: (e) => {
                          // this绑定问题，后续更新17/07
                          // console.log('e', e.target);
                          // console.log('this', this);
                          // this.remove(params.index);
                          console.log('删除！');
                        }
                    }
                  }, '删除')
                ]);
              }else if(status == 1) {
                // return '下线';
                return h('div', [
                  h('Button', {
                    props: {
                        type: 'error',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.remove(params.index)
                          console.log('百家号-1-删除！');
                        }
                    }
                  } , '删除')
                ]);
              }
            }else if(type == '规则') {
              if(status == 0) {
                // return '预览 修改 上线 删除';
                return h('div', [
                  h('Button', {
                    props: {
                        type: 'primary',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.show(params.index)
                          console.log('规则-0-预览！');
                        }
                    }
                  }, '预览'),
                  h('Button', {
                    props: {
                        type: 'primary',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.show(params.index)
                          console.log('规则-0-修改！');
                        }
                    }
                  }, '修改'),
                  h('Button', {
                    props: {
                        type: 'primary',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.show(params.index)
                          console.log('规则-0-上线！');
                        }
                    }
                  }, '上线'),
                  h('Button', {
                    props: {
                        type: 'error',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.remove(params.index)
                          console.log('规则-0-删除！');
                        }
                    }
                  }, '删除')
                ]);
              }else if(status == 1) {
                // return '下线';
                return h('div', [
                  h('Button', {
                    props: {
                        type: 'error',
                        size: 'small'
                    },
                    style: {
                        marginRight: '5px'
                    },
                    on: {
                        click: () => {
                          // this.remove(params.index)
                          console.log('规则-1-下线！');
                        }
                    }
                  } , '下线')
                ]);
              }
            }
          }
        }
      ],
      data1: [
        {
          name: '娱八卦',
          type: '百家号',
          weight: 1,
          status: 0
        },
        {
          name: '关爱八卦协会',
          type: '百家号',
          weight: 1,
          status: 0
        },
        {
          name: '关爱八卦协会',
          type: '百家号',
          weight: 1,
          status: 1
        },
        {
          name: '先验规则1',
          type: '规则',
          weight: 1,
          status: 1
        },
        {
          name: '先验规则2',
          type: '规则',
          weight: 1,
          status: 1
        },
        {
          name: '先验规则3',
          type: '规则',
          weight: 1,
          status: 0
        }
      ],
      total: 100,
      pageSize: 6,
      firstStageList: [
          {
              value: 'yule',
              label: '娱乐'
          },
          {
              value: 'tiyu',
              label: '体育'
          }
      ],
      model1: ''
    }
  },
  methods: {
    mockTableData1() {

      let data = [];
      let rand = Math.floor(Math.random () * 100 + 1);
      for(let i = 0; i < 6; i++) {
        data.push({
          name: '娱八卦' + rand,
          type: '百家号',
          weight: 1,
          status: 0
        });
      }
      return data;
    },
    changePage() {
      // console.log('1');
      this.data1 = this.mockTableData1();
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.page-wrap {
  float: right;
  margin: 16px 0;
}
.search-wrap {
  margin-top: 16px;
}
.table-btn-wrp {
  margin-top: 16px;
  text-align: right;
}
.table-btn-wrp button {
  margin-left: 5px;
  margin-right: 5px;
}
.table-content {
  margin-top: 16px;
}
</style>
