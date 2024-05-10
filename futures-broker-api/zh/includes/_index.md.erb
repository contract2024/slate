# 基础说明

1. 在请求文档中的API接口前，商户需要联系产品经理来获取公私钥。我方需提供一对RSA公私钥，产品经理会将私钥交给商户，商户需将私钥保管好，用于下述步骤使用。
2. 在该商户下创建一个用户交易账户，使用该账户登录web端，获取 APIKey 和 SecretKey。(和使用用户级别openApi步骤一样)
3. 调用商户级别openApi接口，其中请求头需添加下列参数：

> { "X-CH-TS":"时间戳", "Ex-sign":"签名后文本", "Ex-ts":"时间戳"}

4. 采用RSA算法签名，算法如下，其中因签名对参数顺序有要求，paramMap 转成 json 之前需要是红黑树的数据结构。

> paramMap:请求入参
> time:请求头中的EX-ts 时间戳
> signContent：未签名数据
> String signContent = JSON.toJSONString(paramMap) + time

```
/**
     * RSA签名
     * @param content 待签名数据
     * @param priKey 私钥
     * @return 签名值
     */
    public static String sign(String content, String priKey) {
        try {
            PrivateKey privateKey = getPrivateKey(priKey);
            Signature signature = Signature.getInstance(SIGNATURE_ALGORITHM);
            signature.initSign(privateKey);
            signature.update(content.getBytes());
            byte[] signed = signature.sign();
            return Base64.getEncoder().encodeToString(signed);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
```

5. 接口中涉及用户id的输入,接口中总共包含两种用户id.

> coUid:"合约uid (云uid)"
> exUid:"现货uid (originUid)"

6. 接口对入参的类型敏感，字符类型需要使用符号" "包含，数字类型则不需要.

> 字符类型: "输入的参数"
> 数字类型: 100

7. 所有入参如未特殊说明，皆为必传。数字类型分为整数和浮点数，如未特别说明，皆为整数类型.

8. 访问URL示例：

   > ```
   > https://futuresopenapi.xxx.com/v1/inner/interface
   > ```





# 接口信息

注： 以下所有时间格式均为"yyyy-MM-dd HH:mm:ss" 参数和返回值格式均为json，其中key为参数名，value为参数类型和释义，

## 1. 根据商户id,uid和时间查询商户手续费分成

`POST` `/v1/inner/get_broker_fee_share_by_broker_ctime`

入参举例:

```json
{
   "beginTime"    : "2000-01-01 00:00:00",
   "brokerId"     : "0000",
   "coUid"        : "000000",
   "endTime"      : "2001-01-01 00:00:00",
   "limit"        : "10",
   "page"         : "1",
   "type"         : "1",
   "uid"          : "000000"
}

未验签数据举例：
signContent = {"beginTime":"2000-01-01 00:00:00","brokerId":"0000","endTime":"2000-01-01 00:00:00","limit":"10","page":"1","type":"1","uid":"000000"}946656000000
```

#### 入参:

| 字段      | 类型   | 是否必须 | 备注                                                         |
| --------- | ------ | -------- | ------------------------------------------------------------ |
| beginTime | String | 是       | 起始时间                                                     |
| brokerId  | String | 是       | 商户id                                                       |
| coUid     | String | 否       | 如果coUid和uid都传，优先使用uid进行查询.如果没输入则查询所有用户 |
| endTime   | String | 是       | 结束时间                                                     |
| limit     | String | 否       | 每页大小(默认1000 最大1000)                                  |
| page      | String | 否       | 当前页(默认为1)                                              |
| type      | String | 是       | 分成类型,1：商户手续费分成                                   |
| uid       | String | 否       | exUid                                                        |

#### 回参:
```json
{
   "totalShareAmount"          :[number] "总商户分成金额",
   "total"                     :[number] "总条数",
   "totalPlatformShareAmount"  :[String] "总平台分成金额",
   "totalAmount"               :[String] "总分成金额 (商户 + 平台)",
   "records": [{
      "id"                     :[number] "自增id",
      "uid"                    :[number] "exUid",
      "coUid"                  :[number] "coUid",
      "ctime"                  :[String] "创建时间",
      "ctimeStamp"             :[number] "创建时间时间戳",
      "mtime"                  :[String] "修改时间",
      "mtimeStamp"             :[number] "修改时间时间戳",
      "shareAmount"            :[number] "商户分成金额(浮点数类型)",
      "platformShareAmount"    :[number] "平台分成金额",
      "totalShareAmountRecord" :[number] "每条记录的总分成金额(商户 + 平台)",
      "brokerId"               :[number] "商户id",
      "shareRatio"             :[number] "分成比例(浮点数类型)",
      "contractId"             :[number] "合约id"
   }]
}
```
## 仓位列表
`POST` `/v1/inner/get_position_list`

入参举例:

```json
{
  "endDate"   : "2023-06-01 00:00:00",
  "originUid" : "123456",
  "pageNum"   : "1",
  "pageSize"  : "10",
  "startDate" : "2023-01-01 00:00:00",
  "status"    : "0"
}
未验签数据举例：
signContent = {"endDate":"2023-06-01 00:00:00","originUid":"123456","pageNum":"1","pageSize":"10","startDate":"2023-01-01 00:00:00","status":"0"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| endDate   | String | 是    | 结束时间yyyy-MM-dd HH:mm:ss            |
| originUid | String | 是    | exUid                              |
| pageNum   | String | 否    | 当前页                                |
| pageSize  | String | 是    | 每页大小(默认10，最大1000)                  |
| startDate | String | 否    | 起始时间yyyy-MM-dd HH:mm:ss            |
| status    | String | 否    | 仓位状态，0查询历史仓位，1查询当前仓位(非必须，不传查询所有仓位) |

#### 回参:
```json
{
   "total"            :[number] "总条数",
   "current"          :[number] "当前页数",
   "size"             :[number] "每页条数",
   "dataList":[{
      "maxFeeRate"        :[number]  "平仓最大手续费率(浮点数类型)",
      "returnRate"        :[number]  "回报率/收益率(浮点数类型)",
      "positionType"      :[number]  "持仓类型(1 全仓，2 仓逐)",
      "unRealizedAmount"  :[number]  "未实现盈亏(浮点数类型)",
      "avgPrice"          :[number]  "持仓均价(浮点数类型)",
      "tradeFee"          :[number]  "交易手续费(浮点数类型)",
      "buy"               :[String]  "判断是否多仓,是为true,否为false",
      "part"              :[String]  "判断是否是逐仓,是为true,否为false",
      "realizedAmount"    :[number]  "已实现盈亏(浮点数类型)",
      "openPrice"         :[number]  "开仓价格(浮点数类型)",
      "secret"            :[String]  "仓位密钥",
      "mtime"             :[String]  "更新时间",
      "mtimeStamp"        :[String]  "更新时间时间戳",
      "positionValue"     :[number]  "开仓价值（累加）(浮点数类型)",
      "closeProfit"       :[number]  "平仓盈亏(浮点数类型)",
      "coinPrecious"      :[number]  "币种精度",
      "uid"               :[number]  "coUid",
      "originUid"         :[number]  "exUid",
      "lockTime"          :[String]  "爆仓锁仓时间",
      "lockTimeStamp"	  :[String]  "爆仓锁仓时间时间戳",
      "closeVolume"       :[number]  "已平仓数量",
      "keepRate"          :[number]  "阶梯最低维持保证金率(浮点数类型)",
      "ctime"             :[String]  "创建时间",
      "ctimeStamp"        :[String]  "创建时间时间戳",
      "contractName"      :[String]  "合约名称",
      "id"                :[number]  "仓位id",
      "pendingCloseVolume":[number]  "已挂出平仓单的数量",
      "class"             :[String]  "类名(定位仓位数据使用,无需关注)",
      "openRealizedAmount":[number]  "开仓未实现盈亏(浮点数类型)",
      "brokerId"          :[number]  "商户id",
      "side"              :[String]  "持仓方向",
      "indexPrice"        :[number]  "最新标记价格(浮点数类型)",
      "positionBalance"   :[number]  "仓位价值(浮点数类型)",
      "freezeLock"        :[number]  "持仓冻结状态：0 正常，1爆仓冻结，2 交割冻结",
      "leverageLevel"     :[number]  "杠杆倍数",
      "tagPrice"          :[number]  "当前合约标记价格(浮点数类型)",
      "shareAmount"       :[number]  "分摊金额(浮点数类型)",
      "openAmount"        :[number]  "开仓保证金（包括变化量）(浮点数类型)",
      "volume"            :[number]  "持仓数量(浮点数类型)",
      "contractId"        :[number]  "合约id",
      "historyRealizedAmount" :[number]  "历史累计已实现盈亏(浮点数类型)",
      "holdAmount"        :[number]  "持仓保证金(浮点数类型)",
      "closePrice"        :[number]  "平仓均价(浮点数类型)",
      "brokerName"        :[String]  "商户名称",
      "capitalFee"        :[number]  "资金费用(浮点数类型)",
      "status"            :[number]  "仓位有效性，0无效 1有效"
   }]
}

```

## 仓位列表
`POST` `/v1/inner/get_position_list`

入参举例:

```json
{
  "endDate"   : "2023-06-01 00:00:00",
  "originUid" : "123456",
  "pageNum"   : "1",
  "pageSize"  : "10",
  "startDate" : "2023-01-01 00:00:00",
  "status"    : "0"
}
未验签数据举例：
signContent = {"endDate":"2023-06-01 00:00:00","originUid":"123456","pageNum":"1","pageSize":"10","startDate":"2023-01-01 00:00:00","status":"0"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| contractId   | String | 否    | 合约id            |
| contractName | String | 否    | 合约名称(与contractId传其一即可,非必传,没有则查询所有)                              |
| endDate   | String | 否    | 结束时间 yyyy-MM-dd HH:mm:ss                                |
| originUid  | String | 否    | exUid                |
| originUids | String | 否    | 多个exUid以'，'分割，当originUid与originUids同时传入，优先originUid查询。最多输入10个用户id             |
| pageNum    | String | 否    | 页数 |
| pageSize    | String | 否    | 每页大小(默认10，最大1000) |
| startDate    | String | 是    | 起始时间 yyyy-MM-dd HH:mm:ss" |

#### 回参:
```json
{
  "total"    :[number] "总条数",
  "current"  :[number] "当前页数",
  "size"     :[number] "每页条数",
  "dataList":[{
    "id"               :[number] "主键",
    "clientId"         :[number] "客户端订单标识",
    "uid"              :[number] "coUid",
    "positionType"     :[number] "持仓类型(1 全仓，2 仓逐)",
    "open"             :[String] "开平仓方向(open 开仓，close 平仓)",
    "side"             :[String] "买卖方向（buy 买入，sell 卖出）",
    "type"             :[number] "订单类型(1 limit; 2 market; 3 IOC; 4 FOK; 5 POST_ONLY; 6 爆仓,仅在页面展示,非数据库中记录类型;)",
    "leverageLevel"    :[number] "杠杆倍数",
    "price"            :[number] "下单价格(浮点数类型)",
    "volume"           :[number] "下单数量(开仓市价单：金额)(浮点数类型)",
    "openTakerFeeRate" :[number] "开仓maker手续费(浮点数类型)",
    "openMakerFeeRate" :[number] "开仓taker手续费(浮点数类型)",
    "closeTakerFeeRate":[number] "平仓maker手续费(浮点数类型)",
    "closeMakerFeeRate":[number] "平仓taker手续费(浮点数类型)",
    "realizedAmount"   :[number] "订单累计盈亏(浮点数类型)",
    "dealVolume"       :[number] "已成交的数量（张）",
    "dealMoney"        :[number] "已成交的金额(浮点数类型)",
    "avgPrice"         :[number] "成交均价(浮点数类型)",
    "tradeFee"         :[number] "交易手续费(浮点数类型)",
    "status"           :[number] "订单状态（订单状态：0 init，1 new，2 filled，3 part_filled，4 canceled，5 pending_cancel，6 expired）",
    "memo"             :[String] "订单状态备注",
    "source"           :[number] "订单来源（订单来源：1web，2app，3api，4其它）",
    "ctime"            :[String] "创建时间",
    "ctimeStamp"	 :[number] "创建时间时间戳",
    "mtime"            :[String] "更新时间",
    "mtimeStamp"	 :[number] "更新时间时间戳",
    "brokerId"         :[number] "商户ID"
  }]
}

```

## 委托记录
`POST` `/v1/inner/get_entrusted_record`

入参举例:

```json
{
  "contractId"   : "0",
  "contractName" : "E-BTC-USDT",
  "endDate"      : "2023-06-01 00:00:00",
  "originUid"    : "123456",
  "originUids"   : "123456,112312,321231",
  "pageNum"      : "1",
  "pageSize"     : "10",
  "startDate"    : "2023-01-01 00:00:00"
}

未验签数据举例：
signContent = {"contractId":"0","contractName":"E-BTC-USDT","endDate": "2023-06-01 00:00:00","originUid":"123456","originUids":"123456,112312,321231","pageNum":"1","pageSize":"10","startDate": "2023-01-01 00:00:00"}946656000000```
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| contractId   | String | 否    | 合约id            |
| contractName | String | 否    | 合约名称(与contractId传其一即可,非必传,没有则查询所有)                              |
| endDate   | String | 否    | 结束时间 yyyy-MM-dd HH:mm:ss                                |
| originUid  | String | 否    | exUid                |
| originUids | String | 否    | 多个exUid以'，'分割，当originUid与originUids同时传入，优先originUid查询。最多输入10个用户id             |
| pageNum    | String | 否    | 页数 |
| pageSize    | String | 否    | 每页大小(默认10，最大1000) |
| startDate    | String | 是    | 起始时间 yyyy-MM-dd HH:mm:ss" |

#### 回参:
```json
{
  "total"    :[number] "总条数",
  "current"  :[number] "当前页数",
  "size"     :[number] "每页条数",
  "dataList":[{
    "id"               :[number] "主键",
    "clientId"         :[number] "客户端订单标识",
    "uid"              :[number] "coUid",
    "positionType"     :[number] "持仓类型(1 全仓，2 仓逐)",
    "open"             :[String] "开平仓方向(open 开仓，close 平仓)",
    "side"             :[String] "买卖方向（buy 买入，sell 卖出）",
    "type"             :[number] "订单类型(1 limit; 2 market; 3 IOC; 4 FOK; 5 POST_ONLY; 6 爆仓,仅在页面展示,非数据库中记录类型;)",
    "leverageLevel"    :[number] "杠杆倍数",
    "price"            :[number] "下单价格(浮点数类型)",
    "volume"           :[number] "下单数量(开仓市价单：金额)(浮点数类型)",
    "openTakerFeeRate" :[number] "开仓maker手续费(浮点数类型)",
    "openMakerFeeRate" :[number] "开仓taker手续费(浮点数类型)",
    "closeTakerFeeRate":[number] "平仓maker手续费(浮点数类型)",
    "closeMakerFeeRate":[number] "平仓taker手续费(浮点数类型)",
    "realizedAmount"   :[number] "订单累计盈亏(浮点数类型)",
    "dealVolume"       :[number] "已成交的数量（张）",
    "dealMoney"        :[number] "已成交的金额(浮点数类型)",
    "avgPrice"         :[number] "成交均价(浮点数类型)",
    "tradeFee"         :[number] "交易手续费(浮点数类型)",
    "status"           :[number] "订单状态（订单状态：0 init，1 new，2 filled，3 part_filled，4 canceled，5 pending_cancel，6 expired）",
    "memo"             :[String] "订单状态备注",
    "source"           :[number] "订单来源（订单来源：1web，2app，3api，4其它）",
    "ctime"            :[String] "创建时间",
    "ctimeStamp"	 :[number] "创建时间时间戳",
    "mtime"            :[String] "更新时间",
    "mtimeStamp"	 :[number] "更新时间时间戳",
    "brokerId"         :[number] "商户ID"
  }]
}

```

## 查询成交记录
`POST` `/v1/inner/get_trade_record`

入参举例:

```json
{
  "contractId"   : "0",
  "contractName" : "E-BTC-USDT",
  "endDate"      : "2023-06-01 00:00:00",
  "originUid"    : "123456",
  "pageNum"      : "1",
  "pageSize"     : "10",
  "startDate"    : "2023-01-01 00:00:00"
}

未验签数据举例：
signContent = {"contractId":"0","contractName":"E-BTC-USDT","endTime":"1692164611000","originUid":"123456","pageNum":"1","pageSize":"10","startTime":"1674193411000"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| contractId   | String | 否    | 合约id            |
| contractName | String | 否    | 合约名称(与contractId传其一即可,非必传,没有则查询所有)                              |
| endDate   | String | 否    | 结束时间 yyyy-MM-dd HH:mm:ss                                |
| originUid  | String | 否    | exUid                |
| pageNum    | String | 否    | 页数 |
| pageSize    | String | 否    | 每页大小(默认10，最大1000) |
| startDate    | String | 是    | 起始时间 yyyy-MM-dd HH:mm:ss" |

#### 回参:
```json
{
  "total"    :[number] "总条数",
  "current"  :[number] "当前页数",
  "size"     :[number] "每页条数",
  "dataList":
  [{
    "id"        :[number] "主键",
    "price"     :[number] "成交价格(浮点数类型)",
    "volume"    :[number] "成交数量(浮点数类型)",
    "bidId"     :[number] "买单id",
    "askId"     :[number] "卖单id",
    "trendSide" :[String] "主动单方向",
    "bidUserId" :[number] "买单用户ID",
    "askUserId" :[number] "卖单用户ID",
    "buyFee"    :[number] "买单手续费(浮点数类型)",
    "sellFee"   :[number] "卖单手续费(浮点数类型)",
    "bidCid"    :[number] "买单商户ID",
    "askCid"    :[number] "卖单商户ID",
    "ctime"     :[String] "创建时间",
    "ctimeStamp":[number] "创建时间时间戳",
    "mtime"     :[String] "更新时间",
    "mtimeStamp":[number] "更新时间时间戳"
  }]
}


```
## 仓位详情
`POST` `/v1/inner/get_position_detail`

入参举例:

```json
{
  "positionId":"123456"
}
未验签数据举例：
signContent = {"positionId":"123456"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| positionId   | String | 否    | 仓位id            |

#### 回参:
```json
{
  "resultDate": {
    "contactName"             :[String] "合约名称",
    "side"                    :[String] "方向",
    "positionType"            :[number] "持仓类型(1 全仓，2 仓逐)",
    "leverageLevel"           :[number] "杠杆倍数",
    "status"                  :[number] "状态",
    "holdVolume"              :[number] "持有数量(浮点数类型)",
    "closeVolume"             :[number] "手动平仓(浮点数类型)",
    "volume"                  :[number] "持仓数量(浮点数类型)",
    "mergeVolume"             :[number] "合并张数",
    "liquidationVolume"       :[number] "爆仓张数",
    "historyRealizedAmount"   :[number] "历史总盈亏(浮点数类型)",
    "realizedAmount"          :[number] "持仓结算盈亏(浮点数类型)",
    "capitalFee"              :[number] "资金费用(浮点数类型)",
    "tradeFee"                :[number] "手续费(浮点数类型)",
    "shareAmount"             :[number] "分摊金额(浮点数类型)",
    "openPrice"               :[number] "开仓价格(浮点数类型)",
    "openEndPrice"            :[number] "开仓均价终值(浮点数类型)",
    "avgPrice"                :[number] "持仓均价(浮点数类型)",
    "tagPrice"                :[number] "标记价格(浮点数类型)",
    "holdMargin"              :[number] "持仓保证金(浮点数类型)",
    "marginRate"              :[number] "保证金率(浮点数类型)",
    "holdAmount"              :[number] "持仓盈亏(浮点数类型)",
    "closeAmount"             :[number] "平仓盈亏(浮点数类型)",
    "brokerName"              :[String] "商户名称",
    "marginCoin"              :[String] "保证金币种",
    "ctime"                   :[String] "创建时间",
    "ctimeStamp"		:[number] "创建时间时间戳",
    "mtime"                   :[String] "更新时间",
    "mtimeStamp"		:[number] "更新时间时间戳",
    "liquidation":[{
      "lockTime"             :[String] "爆仓时间",
      "lockTimeStamp"	:[number] "爆仓时间时间戳",
      "subVolume"            :[number] "爆仓数量(浮点数类型)",
      "forcedPrice"          :[number] "强平价格(浮点数类型)",
      "takeOverPrice"        :[number] "接管价格(浮点数类型)",
      "openPrice"            :[number] "开仓均价(浮点数类型)",
      "keepRate"             :[number] "维持保证金率(浮点数类型)",
      "liquidationLoss"      :[number] "爆仓亏损(浮点数类型)"
    }]
  }
}
```

## 查询uid列表(按照合约uid正序排列，limit最大限制1000)
`POST` `/v1/inner/get_uid_list`

入参举例:

```json
{
  "limit"   : "100",
  "startUid": "0"
}

未验签数据举例：
signContent = {"limit":"100","startUid":"0"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| limit   | String | 否    | 返回条数 (默认20,最大返回1000条)            |
| startUid   | String | 否    | coUid,用户数据中的第一个开始id,第一次查询输入0 (返回值不包含该uid)            |

#### 回参:
```json
{
  "msg":"成功",
  "code":"0",
  "data":
  {"uidInfo":
  [{
    "coUid": [number] "合约uid(云uid)",
    "exUid": [number] "现货uid(originUid)"
  }]
  }
}
```

## 查询划转记录列表
`POST` `/v1/inner/get_trans_records`

入参举例:

```json
{
  "endTime"      : "948656000000",
  "limit"        : "10",
  "page"         : "1",
  "startTime"    : "946656000000",
  "transferType" : "wallet_to_contract",
  "uid"          : "123456"
}
未验签数据举例：
signContent = {"endTime":"948656000000","limit":"10","page":"1","startTime":"946656000000","transferType":"wallet_to_contract","uid":"123456"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| endTime   | String | 是    | 结束时间戳            |
| limit   | String | 否    | 返回条数 (默认20,最大返回1000条)            |
| page   | String | 否    | 页码数            |
| startTime   | String | 是    | 起始时间戳            |
| transferType   | String | 否    | 划转方向类型(包含合约转现货：contract_to_wallet，以及现货转合约：wallet_to_contract)            |
| uid   | String | 否    | coUid(非必传,不传查询所有记录)            |

#### 回参:
```json
{
  "msg":"成功",
  "code":"0",
  "data":
  {"transRecords":
  [{
    "uid"          :[number] "coUid",
    "amount"       :[number] "划转金额(浮点数类型)",
    "unionId"      :[String] "唯一id",
    "coinSymbol"   :[String] "划转币种",
    "transferType" :[String] "划转方向类型",
    "ctime"        :[String] "划转记录创建时间",
    "ctimeStamp"	:[number] "划转记录创建时间时间戳",
    "type"         :[number] "划转类型（1:普通划转, 2:赠金划转）",
    "brokerName"   :[String] "商户名称",
    "status"       :[number] "划转状态（0:支付中, 1:成功, 2:失败）"
  }]
  }
}
```

## 查询商户下的所有用户资产
`POST` `/v1/inner/get_trans_records`

入参举例:

```json
{
  "endDate"   : "2023-06-01 00:00:00",
  "page"      : 1,
  "pageSize"  : 10,
  "startDate" : "2023-01-01 00:00:00",
  "uid"       : 123456
}
未验签数据举例：
signContent = {"endDate":"2023-06-01 00:00:00","page":1,"pageSize":10,"startDate":"2023-01-01 00:00:00","uid":123456}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| endDate   | String | 是    | 结束时间yyyy-MM-dd HH:mm:ss            |
| pageSize   | String | 否    | 返回条数 (默认20,最大返回1000条)            |
| page   | String | 否    | 页码数            |
| startTime   | String | 是    | 起始时间戳            |
| uid   | String | 否    | coUid(非必传,不传查询所有用户的资产)            |

#### 回参:
```json
{
  "code": "0",
  "data":
  {
    "record":
    [{
      "uid"         :[number]  "coUid",
      "totalBalance":[number]  "用户总资产(浮点数类型)",
      "symbol"      :[String]  "币种",
    }],
    "total":[number] "总条数"
  },
  "msg": "成功"
}
```

## 查询商户下的保险基金总额和保险基金流水
`POST` `/v1/inner/risk_amount`

入参举例:

```json
{
  "endDate"   : "2023-06-01 00:00:00",
  "page"      : 1,
  "pageSize"  : 10,
  "startDate" : "2023-01-01 00:00:00"
}
未验签数据举例：
signContent = {"endDate":"2023-06-01 00:00:00","page":1,"pageSize":10,"startDate":"2023-01-01 00:00:00"}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                 |
|-----------|--------|------|------------------------------------|
| endDate   | String | 是    | 结束时间yyyy-MM-dd HH:mm:ss            |
| pageSize   | String | 否    | 返回条数 (默认20,最大返回1000条)            |
| page   | String | 否    | 页码数            |
| startDate   | String | 是    | 起始时间 yyyy-MM-dd HH:mm:ss            |

#### 回参:
```json
{
  "code": "0",
  "data":
  {
    "riskAmount":[number]  "商户保险基金总额(浮点数类型)",
    "symbol"    :[String]  "币种",
    "total"     :[number]  "保险基金流水总条数",
    "record":
    [{
      "symbol" 	:[String]  "币种",
      "mTime"  	:[number]  "流水记录时间戳",
      "mTimeDate"    :[String]  "流水记录时间",
      "amount" 	:[number]  "流水金额(正负 区分收入支出)(浮点数类型)"
    }]
  },
  "msg": "成功"
}

```

## 查询商户下的合约信息
`GET` `/fapi/v1/contracts`


#### 回参:
```json
{
  "symbol"           :[String]  "合约名称",
  "pricePrecision"   :[number]  "价格精度",
  "side"             :[number]  "合约方向 0反向 1正向",
  "maxMarketVolume"  :[number]  "市价单最大下单数量",
  "multiplier"       :[number]  "合约面值(浮点数类型)",
  "minOrderVolume"   :[number]  "最小下单量",
  "maxMarketMoney"   :[number]  "市价最大下单金额(浮点数类型)",
  "type"             :[String]  "合约类型，E:永续合约 W:周 N:次周 M:月 Q:季度",
  "maxLimitVolume"   :[number]  "限价单最大下单数量",
  "maxValidOrder"    :[number]  "最大有效委托的订单数量",
  "multiplierCoin"   :[String]  "合约面值单位",
  "minOrderMoney"    :[number]  "最小下单金额(浮点数类型)",
  "maxLimitMoney"    :[number]  "限价单最大下单金额(浮点数类型)",
  "contractId"       :[number]  "合约id",
  "status"           :[number]  "合约状态（0：不可交易，1：可交易）"
}

```

## 查询用户资产
`POST` `/v1/inner/user_account_balance`

入参举例:

```json
{
  "coin" : "USDT",
  "uid"  : 123456,
  "pageSize" : 1,
  "pageNum" : 10
}
未验签数据举例：
signContent = {"coin":"USDT","uid":123456,"pageSize":1,"pageNum":10}946656000000
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                                           |
|-----------|--------|------|--------------------------------------------------------------|
| coin   | String | 是    | 查询的保证金币种                                                     |
| uid   | number | 否    | exUid                                                        |
| pageSize   | number | 否    | 页数大小 最大100(但目前由于查询性能问题，建议最大pageSize <= 30进行查询) |
| pageNum   | number | 否    | 当前页数 (当查询指定uid时，将pageNum置为1) |

#### 回参:
```json
{
  "code": "0",
  "data": [
    {
      "uid"             :[number] "exUid",
      "crossBalance"    :[String] "全仓资产",
      "isolatedBalance" :[String] "逐仓资产",
      "totalBalance"    :[String] "用户总资产",
      "frozenBalance"   :[String] "冻结资产"
    }
  ],
  "msg": "成功"
}

```

## 查询用户流水
`POST` ` /v1/inner/transaction_funding_record`

入参举例:

```json
{
  "beginTime" : "2023-01-01 08:00:00",
  "endTime"   : "2023-01-02 08:00:00",
  "page"      : 1,
  "limit"     : 10,
  "uid"       : 3221231
}

未验签数据举例：
signContent = {"beginTime":"2023-01-01 08:00:00","endTime":"2023-01-02 08:00:00","page":1,"limit":10,"uid":3221231}946656000000```
```

#### 入参:

| 字段        | 类型     | 是否必须 | 备注                                             |
|-----------|--------|------|------------------------------------------------|
| beginTime   | String | 是    | 查询开始时间 格式为:yyyy-MM-dd HH:mm:ss                      |
| endTime   | number | 否    | 查询结束时间 格式为:yyyy-MM-dd HH:mm:ss                      |
| limit   | number | 否    | 每页显示数据数量，默认100，最大100 |
| page   | number | 否    | 当前页，默认为1                  |
| uid   | number | 是    | coUid 合约用户id                                          |

#### 回参:
```json
{
  "data": [
    {
      "uid",
      "contractName",
      "contractOtherName":,
      "timeStamp",
      "type",
      "date",
      "amount"
    }
  ],
  "page",
  "limit"
}

```
