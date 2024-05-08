---
title: <%= t(:hello) %> World


language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Kittn API
---

# 更新日志

2024.04.15 更新API风格


# 基本信息 

## Rest基本信息

- 本篇列出REST接口的baseurl: **htts://futuresopenapi.xxx.xxx**
- 所有接口都会返回一个JSON object或者array.
- 响应中如有数组，数组元素以时间倒序排列，越早的数据越提前.
- 所有时间、时间戳均为UNIX时间，单位为毫秒.
- 所有数据类型采用JAVA的数据类型定义.

## 接口错误代码
- 每个接口都有可能抛出异常
- 具体的错误代码及其解释在错误代码

## HTTP返回代码
- HTTP `4XX` 错误码用于指示错误的请求内容、行为、格式.
- HTTP `429` 错误码表示警告访问频次超限，即将被封IP.
- HTTP `418` 表示收到429后继续访问，于是被封了.
- HTTP `5XX` 返回错误码是内部系统错误；这说明这个问题是在服务器这边。在对待这个错误时，千万不要把它当成一个失败的任务，因为执行状态未知，有可能成功也有可能是失败.
- HTTP `504` 表示API服务端已经向业务核心提交了请求但未能获取响应，特别需要注意的是504代码不代表请求失败，而是未知。很可能已经得到了执行，也有可能执行失败，需要做进一步确认.
- 任何接口都可能返回ERROR(错误); 错误的返回payload如下:
>{
"code": -1121,
"msg": "Invalid symbol."
}

## 接口通用信息
- 所有请求基于Https协议，请求头信息中Content-Type需要统一设置为: 'application/json'
- GET方法的接口, 参数必须在query string中发送.
- POST方法的接口, 参数必须在request body中发送
- 对参数的顺序不做要求。

## 访问限制
- 在每个接口下面会有限频的说明.
- 违反频率限制都会收到HTTP 429，这是一个警告.
- 当收到429告警时，调用者应当降低访问频率或者停止访问.

## 接口鉴权类型
- 每个接口都有自己的鉴权类型，鉴权类型决定了访问时应当进行何种鉴权
- 如果需要 `API-key`，应当在HTTP头中以`X-CH-APIKEY`字段传递
- `API-key` 与 `API-secret` 是大小写敏感的
- 可以在网页用户中心修改API-key 所具有的权限，例如读取账户信息、发送交易指令、发送提现指令

| 鉴权类型        | 描述             |
|-------------|----------------|
| NONE        | 不需要鉴权的接口       |
| TRADE       | 需要有效API-KEY和签名 |
| USER_DATA   | 需要有效API-KEY和签名 |
| USER_STREAM | 需要有效的API-KEY   |
| MARKET_DATA | 需要有效的API-KEY   |

## 需要签名的接口(TRADE与USER_DATA)
- 调用`TRADE`或者`USER_DATA`接口时，应当在HTTP头中以`X-CH-SIGN`字段传递签名参数.
- 签名使用HMAC `SHA256算法`. API-KEY所对应的API-Secret作为 `HMAC SHA256` 的密钥.
- `X-CH-SIGN`的请求头是以timestamp + method + requestPath + body字符串(+表示字符串连接)作为操作对象
- 其中`timestamp`的值与`X-CH-TS`请求头相同, method是请求方法，字母全部大写：GET/POST.
- requestPath是请求接口路径 例如:/sapi/v1/order?orderId=211222334&symbol=BTCUSDT
- body是请求主体的字符串(post only) 如果是GET请求则body可省略
- 签名大小写不敏感

## 时间同步安全
- 签名接口均需要在HTTP头中以`X-CH-TS`字段传递时间戳, 其值应当是请求发送时刻的unix时间戳（毫秒） e.g. 1528394129373
- 服务器收到请求时会判断请求中的时间戳，如果是5000毫秒之前发出的，则请求会被认为无效。这个时间窗口值可以通过发送可选参数`recvWindow`来自定义。\
- 另外，如果服务器计算得出客户端时间戳在服务器时间的‘未来’一秒以上，也会拒绝请求。
- 逻辑伪代码：

```javascript
if (timestamp < (serverTime + 1000) && (serverTime - timestamp) <= recvWindow) {
  // process request
} else {
  // reject request
}
```

**关于交易时效性** 互联网状况并不100%可靠，不可完全依赖,因此你的程序本地到交易所服务器的时延会有抖动. 这是我们设置recvWindow的目的所在，如果你从事高频交易，对交易时效性有较高的要求，可以灵活设置recvWindow以达到你的要求。 不推荐使用5秒以上的recvWindow

## POST /sapi/v1/order/test 的示例
以下是在linux bash环境下使用 echo openssl 和curl工具实现的一个调用接口下单的示例 apikey、secret仅供示范

| key       | value                            |
|-----------|----------------------------------|
| apikey    | vmPUZE6mv9SD5V5e14y7Ju91duEh8A   |
| secretKey | 902ae3cb34ecee2779aa4d3e1d226686 |

| 参数     | 取值      |
|--------|---------|
| symbol | BTCUSDT |
| side   | BUY     |
| type   | LIMIT   |
| volume | 1       |
| price  | 9300    |

## 签名示例

- body
> {"symbol":"BTCUSDT","price":"9300","volume":"1","side":"BUY","type":"LIMIT"}

```shell
HMAC SHA256 签名:
[linux]$ echo -n "1588591856950POST/sapi/v1/order/test{\"symbol\":\"BTCUSDT\",\"price\":\"9300\",\"volume\":\"1\",\"side\":\"BUY\",\"type\":\"LIMIT\"}" | openssl dgst -sha256 -hmac "902ae3cb34ecee2779aa4d3e1d226686"
(stdin)= c50d0a74bb9427a9a03933d0eded03af9bf50115dc5b706882a4fcf07a26b761
```

```shell
curl 调用:
(HMAC SHA256)
  [linux]$ curl -H "X-CH-APIKEY: c3b165fd5218cdd2c2874c65da468b1e" -H "X-CH-SIGN: c50d0a74bb9427a9a03933d0eded03af9bf50115dc5b706882a4fcf07a26b761" -H "X-CH-TS: 1588591856950" -H "Content-Type:application/json" -X POST 'http://localhost:30000/sapi/v1/order/test' -d '{"symbol":"BTCUSDT","price":"9300","quantity":"1","side":"BUY","type":"LIMIT"}'
```

## ENUM
### 术语解释
- `base` 指一个交易对的交易对象，即写在靠前部分的资产名
- `quote` 指一个交易对的定价资产，即写在靠后部分资产名

### 订单状态
- `NEW` 新建订单
- `PARTIALLY_FILLED`  部分成交
- `FILLED`  全部成交 
- `CANCELED`  已撤销 
- `PENDING_CANCEL` 正在撤销中 
- `REJECTED` 订单被拒绝

### 订单种类
- `LIMIT` 限价单
- `MARKET` 市价单

### 订单方向
- `BUY` 买单
- `SELL` 卖单

### K线间隔
- `1min`
- `5min`
- `15min`
- `30min`
- `60min`
- `1h`
- `4h`
- `1day`
- `1week`
- `1month`

# 行情接口

## 安全类型:`None`
公共下方的接口不需要API-key或者签名就能自由访问

## 测试连接

`GET` `https://futuresopenapi.xxx.com/fapi/v1/ping`

**测试服务器连通性 PING**

参数: `NONE`

> 响应:

```json
{}
```

## 获取服务器时间
`GET` `https://futuresopenapi.xxx.com/fapi/v1/time`

**获取服务器时间**

参数: `NONE`

> 响应:


```json
{
  "serverTime":1607702400000, //服务器时间戳
  "timezone":"中国标准时间" //服务器时区
}
```

## 合约列表
`GET` `https://futuresopenapi.xxx.com/fapi/v1/contracts`

**合约列表**

参数: `NONE`

> 响应:

```json
[
    {
        "symbol": "H-HT-USDT", // 合约名称
        "pricePrecision": 8, // 价格精度
        "side": 1, // 合约方向 (0: 反向，1：正向)
        "maxMarketVolume": 100000, // 市价最大下单量
        "multiplier": 6, // 合约面值
        "minOrderVolume": 1, // 最小下单量
        "maxMarketMoney": 10000000, //市价最大下单金额
        "type": "H", // 合约类型 (E:永续合约，S:模拟合约，其他为混合合约)
        "maxLimitVolume": 1000000, // 限价单最大下单数量
        "maxValidOrder": 20, // 最大有效委托的订单数量
        "multiplierCoin": "HT", // 合约面值单位
        "minOrderMoney": 0.001, // 最小下单金额
        "maxLimitMoney": 1000000, //限价单最大下单数量
        "status": 1 //合约状态（0：不可交易，1：可交易
    }
]
```

## 订单薄

`GET` `https://futuresopenapi.xxx.com/fapi/v1/depth`

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| limit        | Integer | 默认100;最大100       |
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
  "bids": [
    [
      "3.90000000",   // 价格
      "431.00000000"  // 数量
    ],
    [
      "4.00000000",
      "431.00000000"
    ]
  ],
  "asks": [
    [
      "4.00000200",  // 价格
      "12.00000000"  // 数量
    ],
    [
      "5.10000000",
      "28.00000000"
    ]
  ]
}
```
### 行情ticker
`GET` `https://futuersopenapi.xxx.com/fapi/v1/ticker`

24小时价格变化数据

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
    "high": "9279.0301", //时间戳
    "vol": "1302", //交易量
    "last": "9200", //最新价
    "low": "9279.0301", //最低价
    "rose": "0", // 涨跌幅
    "time": 1595563624731 // 时间戳
}
```
### 获取指数/标记价格
`GET` `https://futuersopenapi.xxx.com/fapi/v1/index`

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| limit        | Integer | 默认100;最大100       |
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
    "markPrice": 581.5, //标记价格
    "indexPrice": 646.393, // 指数价格
    "lastFundingRate": 0.001, // 本期资金费率
    "contractName": "E-ETH-USDT", //合约名称
    "time": 1608273554063 // 时间戳
}
```

### K线/蜡烛图数据
`GET` `https://futuresopenapi.xxx.com/fapi/v1/klines`

#### 参数
| 字段           | 类型      | 是否必须 | 备注                                                                                             |
|--------------|---------|------|------------------------------------------------------------------------------------------------|
| contractName | string  | 是    | 合约名称大写 如 E-BTC-USDT                                                                            |
| interval     | string  | 是    | k线图区间, 可识别的参数值为： 1min,5min,15min,30min,1h,1day,1week,1month（min=分钟，h=小时,day=天，week=星期，month=月） |
| limit        | integer | 否    | 默认100; 最大300                                                                                   |
| startTime    | long    | 否    | 时间戳，毫秒（ms）                                                                                     |
| endTime      | long    | 否    | 时间戳，毫秒（ms）                                                                                     |
> 响应:

```json
[
    {
        "high": "6228.77",//最高价
        "vol": "111",//成交量
        "low": "6228.77",//最低价
        "idx": 1594640340,//开始时间戳，毫秒（ms）
        "close": "6228.77",//收盘价
        "open": "6228.77"//开盘价
    },
    {
        "high": "6228.77",
        "vol": "222",
        "low": "6228.77",
        "idx": 1587632160,
        "close": "6228.77",
        "open": "6228.77"
    },
    {
        "high": "6228.77",
        "vol": "333",
        "low": "6228.77",
        "idx": 1587632100,
        "close": "6228.77",
        "open": "6228.77"
    }
]
```
# 交易相关
## 安全类型: TRADE
交易下方的接口都需要签名和API-KEY验证

## 创建订单
`GET` `https://futuresopenapi.xxx.com/fapi/v1/order`
#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数

| 字段            | 类型     | 是否必须 | 备注                          |
|---------------|--------|------|-----------------------------|
| volume        | number | 是    | 下单张数,市价开仓为价值.有精度限制,精度由管理员设置 |
| price         | number | 否    | 下单价格,限价单:必传,有精度限制,精度有管理员设置  |
| contractName  | string | 是    | 大写合约名称:`E-BTC-USDT`         |
| type          | string | 是    | 订单类型:`LIMIT/MARKET`         |
| side          | string | 是    | 买卖方向`BUY/SELL`              |
| open          | string | 是    | 开平仓方向`OPEN/CLOSE`           |
| positionType  | number | 否    | 持仓类型:`1:全仓/2:逐仓`            |
| clientOrderId | string | 否    | 客户端下单标识,长度小32位              |
| timeInForce   | string | 否    | `IOC,FOK,POST_ONLY`         |

> 响应:

```json
{
    "orderId": 256609229205684228//订单ID
}
```
## 创建条件单

`POST` `https://futuresopenapi.xxx.com/fapi/v1/conditionOrder/`
#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数

| 字段            | 类型     | 是否必须 | 备注                          |
|---------------|--------|------|-----------------------------|
| triggerType   | string | 是    | 条件单类型:`1:止损/2:止盈/3:追涨/4:杀跌` |     
| triggerPrice  | string | 是    | 触发价                         |     
| volume        | number | 是    | 下单张数,市价开仓为价值.有精度限制,精度由管理员设置 |
| price         | number | 否    | 下单价格,限价单:必传,有精度限制,精度有管理员设置  |
| contractName  | string | 是    | 大写合约名称:`E-BTC-USDT`         |
| type          | string | 是    | 订单类型:`LIMIT/MARKET`         |
| side          | string | 是    | 买卖方向`BUY/SELL`              |
| open          | string | 是    | 开平仓方向`OPEN/CLOSE`           |
| positionType  | number | 否    | 持仓类型:`1:全仓/2:逐仓`            |
| clientOrderId | string | 否    | 客户端下单标识,长度小32位              |

> 响应:

```json
{
    "code": "0",
    "msg": "Success",
    "data": {
        "triggerIds": [
            "1322738336974712847"//条件单ID
        ],
        "ids": [],
        "cancelIds": []
    },
    "succ": true
}
```
## 取消订单
`POST` `https://futuresopenapi.xxx.com/fapi/v1/cancel`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段           | 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| orderId      | string | 是    | 订单ID                |

> 响应:

```json
{
    "orderId": 256609229205684228//订单ID
}
```
## 订单详情
`GET` `https://futuresopenapi.xxx.com/fapi/v1/order`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段            | 类型     | 是否必须 | 备注                  |
|---------------|--------|------|---------------------|
| contractName  | string | 是    | 大写合约名称 `E-BTC-USDT` |
| orderId       | string | 是    | 订单ID                |
| clientOrderId | string | 否    | 客户端唯一标识             |

> 响应:

```json
{
    "side": "BUY",//订单方向
    "executedQty": 0,//成交数量
    "orderId": 2006628907041292645,//订单ID
    "price": 2000.0000000000000000,//委托价格
    "origQty": 2.0000000000000000,//委托数量
    "avgPrice": 0E-8,//成交均价
    "transactTime": 1704967622000,//订单创建时间
    "action": "OPEN",//OPEN/CLOSE
    "contractName": "E-BTC-USDT",//合约名称
    "type": "LIMIT",//订单类型
    "timeInForce": "",//条件单有效方式1 limit， 2 market，3 IOC，4 FOK，5 POST_ONLY
    "status": "NEW"//订单状态。可能出现的值为：NEW(新订单，无成交)、PARTIALLY_FILLED（部分成交）、FILLED（全部成交）、CANCELED（已取消）和REJECTED（订单被拒绝）
}
```
## 当前订单
`GET` `https://futuresopenapi.xxx.com/fapi/v1/openOrders`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段            | 类型     | 是否必须 | 备注                  |
|---------------|--------|------|---------------------|
| contractName  | string | 是    | 大写合约名称 `E-BTC-USDT` |

> 响应:

```json
[
    {
       "side": "BUY",//订单方向
       "executedQty": 0,//成交数量,可能出现的值只能为：BUY（买入做多） 和 SELL（卖出做空）
       "orderId": 259396989397942275,//订单ID
       "price": 10000.0000000000000000,//订单价格
       "origQty": 1.0000000000000000,//订单数量
       "avgPrice": 0E-8,//成交均价
       "transactTime": "1607702400000",//订单创建时间
       "action": "OPEN",//CLOSE/BUY
       "contractName": "E-BTC-USDT",//合约名称
       "type": "LIMIT",//订单类型。可能出现的值只能为:LIMIT(限价)和MARKET（市价）
       "status": "INIT"//订单状态。可能出现的值为：NEW(新订单，无成交)、PARTIALLY_FILLED（部分成交）、FILLED（全部成交）、CANCELED（已取消）和REJECTED（订单被拒绝）
    }
]
```
## 历史委托
`GET` `https://futuresopenapi.xxx.com/fapi/v1/orderHistorical`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段        ---
title: 合约交易
language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
- javascript

toc_footers:
- <a href='#'>Sign Up for a Developer Key</a>
- <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
- errors

search: true

code_clipboard: true

meta:
- name: description
  content: Documentation for the Kittn API
---

# 更新日志

2024.04.15 更新API风格


# 基本信息

## Rest基本信息

- 本篇列出REST接口的baseurl: **htts://futuresopenapi.xxx.xxx**
- 所有接口都会返回一个JSON object或者array.
- 响应中如有数组，数组元素以时间倒序排列，越早的数据越提前.
- 所有时间、时间戳均为UNIX时间，单位为毫秒.
- 所有数据类型采用JAVA的数据类型定义.

## 接口错误代码
- 每个接口都有可能抛出异常
- 具体的错误代码及其解释在错误代码

## HTTP返回代码
- HTTP `4XX` 错误码用于指示错误的请求内容、行为、格式.
- HTTP `429` 错误码表示警告访问频次超限，即将被封IP.
- HTTP `418` 表示收到429后继续访问，于是被封了.
- HTTP `5XX` 返回错误码是内部系统错误；这说明这个问题是在服务器这边。在对待这个错误时，千万不要把它当成一个失败的任务，因为执行状态未知，有可能成功也有可能是失败.
- HTTP `504` 表示API服务端已经向业务核心提交了请求但未能获取响应，特别需要注意的是504代码不代表请求失败，而是未知。很可能已经得到了执行，也有可能执行失败，需要做进一步确认.
- 任何接口都可能返回ERROR(错误); 错误的返回payload如下:
>{
"code": -1121,
"msg": "Invalid symbol."
}

## 接口通用信息
- 所有请求基于Https协议，请求头信息中Content-Type需要统一设置为: 'application/json'
- GET方法的接口, 参数必须在query string中发送.
- POST方法的接口, 参数必须在request body中发送
- 对参数的顺序不做要求。

## 访问限制
- 在每个接口下面会有限频的说明.
- 违反频率限制都会收到HTTP 429，这是一个警告.
- 当收到429告警时，调用者应当降低访问频率或者停止访问.

## 接口鉴权类型
- 每个接口都有自己的鉴权类型，鉴权类型决定了访问时应当进行何种鉴权
- 如果需要 `API-key`，应当在HTTP头中以`X-CH-APIKEY`字段传递
- `API-key` 与 `API-secret` 是大小写敏感的
- 可以在网页用户中心修改API-key 所具有的权限，例如读取账户信息、发送交易指令、发送提现指令

| 鉴权类型        | 描述             |
|-------------|----------------|
| NONE        | 不需要鉴权的接口       |
| TRADE       | 需要有效API-KEY和签名 |
| USER_DATA   | 需要有效API-KEY和签名 |
| USER_STREAM | 需要有效的API-KEY   |
| MARKET_DATA | 需要有效的API-KEY   |

## 需要签名的接口(TRADE与USER_DATA)
- 调用`TRADE`或者`USER_DATA`接口时，应当在HTTP头中以`X-CH-SIGN`字段传递签名参数.
- 签名使用HMAC `SHA256算法`. API-KEY所对应的API-Secret作为 `HMAC SHA256` 的密钥.
- `X-CH-SIGN`的请求头是以timestamp + method + requestPath + body字符串(+表示字符串连接)作为操作对象
- 其中`timestamp`的值与`X-CH-TS`请求头相同, method是请求方法，字母全部大写：GET/POST.
- requestPath是请求接口路径 例如:/sapi/v1/order?orderId=211222334&symbol=BTCUSDT
- body是请求主体的字符串(post only) 如果是GET请求则body可省略
- 签名大小写不敏感

## 时间同步安全
- 签名接口均需要在HTTP头中以`X-CH-TS`字段传递时间戳, 其值应当是请求发送时刻的unix时间戳（毫秒） e.g. 1528394129373
- 服务器收到请求时会判断请求中的时间戳，如果是5000毫秒之前发出的，则请求会被认为无效。这个时间窗口值可以通过发送可选参数`recvWindow`来自定义。\
- 另外，如果服务器计算得出客户端时间戳在服务器时间的‘未来’一秒以上，也会拒绝请求。
- 逻辑伪代码：

```javascript
if (timestamp < (serverTime + 1000) && (serverTime - timestamp) <= recvWindow) {
  // process request
} else {
  // reject request
}
```

**关于交易时效性** 互联网状况并不100%可靠，不可完全依赖,因此你的程序本地到交易所服务器的时延会有抖动. 这是我们设置recvWindow的目的所在，如果你从事高频交易，对交易时效性有较高的要求，可以灵活设置recvWindow以达到你的要求。 不推荐使用5秒以上的recvWindow

## POST /sapi/v1/order/test 的示例
以下是在linux bash环境下使用 echo openssl 和curl工具实现的一个调用接口下单的示例 apikey、secret仅供示范

| key       | value                            |
|-----------|----------------------------------|
| apikey    | vmPUZE6mv9SD5V5e14y7Ju91duEh8A   |
| secretKey | 902ae3cb34ecee2779aa4d3e1d226686 |

| 参数     | 取值      |
|--------|---------|
| symbol | BTCUSDT |
| side   | BUY     |
| type   | LIMIT   |
| volume | 1       |
| price  | 9300    |

## 签名示例

- body
> {"symbol":"BTCUSDT","price":"9300","volume":"1","side":"BUY","type":"LIMIT"}

```shell
HMAC SHA256 签名:
[linux]$ echo -n "1588591856950POST/sapi/v1/order/test{\"symbol\":\"BTCUSDT\",\"price\":\"9300\",\"volume\":\"1\",\"side\":\"BUY\",\"type\":\"LIMIT\"}" | openssl dgst -sha256 -hmac "902ae3cb34ecee2779aa4d3e1d226686"
(stdin)= c50d0a74bb9427a9a03933d0eded03af9bf50115dc5b706882a4fcf07a26b761
```

```shell
curl 调用:
(HMAC SHA256)
  [linux]$ curl -H "X-CH-APIKEY: c3b165fd5218cdd2c2874c65da468b1e" -H "X-CH-SIGN: c50d0a74bb9427a9a03933d0eded03af9bf50115dc5b706882a4fcf07a26b761" -H "X-CH-TS: 1588591856950" -H "Content-Type:application/json" -X POST 'http://localhost:30000/sapi/v1/order/test' -d '{"symbol":"BTCUSDT","price":"9300","quantity":"1","side":"BUY","type":"LIMIT"}'
```

## ENUM
### 术语解释
- `base` 指一个交易对的交易对象，即写在靠前部分的资产名
- `quote` 指一个交易对的定价资产，即写在靠后部分资产名

### 订单状态
- `NEW` 新建订单
- `PARTIALLY_FILLED`  部分成交
- `FILLED`  全部成交
- `CANCELED`  已撤销
- `PENDING_CANCEL` 正在撤销中
- `REJECTED` 订单被拒绝

### 订单种类
- `LIMIT` 限价单
- `MARKET` 市价单

### 订单方向
- `BUY` 买单
- `SELL` 卖单

### K线间隔
- `1min`
- `5min`
- `15min`
- `30min`
- `60min`
- `1h`
- `4h`
- `1day`
- `1week`
- `1month`

# 行情接口

## 安全类型:`None`
公共下方的接口不需要API-key或者签名就能自由访问

## 测试连接

`GET` `https://futuresopenapi.xxx.com/fapi/v1/ping`

**测试服务器连通性 PING**

参数: `NONE`

> 响应:

```json
{}
```

## 获取服务器时间
`GET` `https://futuresopenapi.xxx.com/fapi/v1/time`

**获取服务器时间**

参数: `NONE`

> 响应:


```json
{
  "serverTime":1607702400000, //服务器时间戳
  "timezone":"中国标准时间" //服务器时区
}
```

## 合约列表
`GET` `https://futuresopenapi.xxx.com/fapi/v1/contracts`

**合约列表**

参数: `NONE`

> 响应:

```json
[
    {
        "symbol": "H-HT-USDT", // 合约名称
        "pricePrecision": 8, // 价格精度
        "side": 1, // 合约方向 (0: 反向，1：正向)
        "maxMarketVolume": 100000, // 市价最大下单量
        "multiplier": 6, // 合约面值
        "minOrderVolume": 1, // 最小下单量
        "maxMarketMoney": 10000000, //市价最大下单金额
        "type": "H", // 合约类型 (E:永续合约，S:模拟合约，其他为混合合约)
        "maxLimitVolume": 1000000, // 限价单最大下单数量
        "maxValidOrder": 20, // 最大有效委托的订单数量
        "multiplierCoin": "HT", // 合约面值单位
        "minOrderMoney": 0.001, // 最小下单金额
        "maxLimitMoney": 1000000, //限价单最大下单数量
        "status": 1 //合约状态（0：不可交易，1：可交易
    }
]
```

## 订单薄

`GET` `https://futuresopenapi.xxx.com/fapi/v1/depth`

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| limit        | Integer | 默认100;最大100       |
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
  "bids": [
    [
      "3.90000000",   // 价格
      "431.00000000"  // 数量
    ],
    [
      "4.00000000",
      "431.00000000"
    ]
  ],
  "asks": [
    [
      "4.00000200",  // 价格
      "12.00000000"  // 数量
    ],
    [
      "5.10000000",
      "28.00000000"
    ]
  ]
}
```
### 行情ticker
`GET` `https://futuersopenapi.xxx.com/fapi/v1/ticker`

24小时价格变化数据

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
    "high": "9279.0301", //时间戳
    "vol": "1302", //交易量
    "last": "9200", //最新价
    "low": "9279.0301", //最低价
    "rose": "0", // 涨跌幅
    "time": 1595563624731 // 时间戳
}
```
### 获取指数/标记价格
`GET` `https://futuersopenapi.xxx.com/fapi/v1/index`

#### 参数
| 字段           | 类型      | 备注                |
|--------------|---------|-------------------|
| limit        | Integer | 默认100;最大100       |
| contractName | String  | 合约名称 如:E-BTC-USDT |

> 响应:

```json
{
    "markPrice": 581.5, //标记价格
    "indexPrice": 646.393, // 指数价格
    "lastFundingRate": 0.001, // 本期资金费率
    "contractName": "E-ETH-USDT", //合约名称
    "time": 1608273554063 // 时间戳
}
```

### K线/蜡烛图数据
`GET` `https://futuresopenapi.xxx.com/fapi/v1/klines`

#### 参数
| 字段           | 类型      | 是否必须 | 备注                                                                                             |
|--------------|---------|------|------------------------------------------------------------------------------------------------|
| contractName | string  | 是    | 合约名称大写 如 E-BTC-USDT                                                                            |
| interval     | string  | 是    | k线图区间, 可识别的参数值为： 1min,5min,15min,30min,1h,1day,1week,1month（min=分钟，h=小时,day=天，week=星期，month=月） |
| limit        | integer | 否    | 默认100; 最大300                                                                                   |
| startTime    | long    | 否    | 时间戳，毫秒（ms）                                                                                     |
| endTime      | long    | 否    | 时间戳，毫秒（ms）                                                                                     |
> 响应:

```json
[
    {
        "high": "6228.77",//最高价
        "vol": "111",//成交量
        "low": "6228.77",//最低价
        "idx": 1594640340,//开始时间戳，毫秒（ms）
        "close": "6228.77",//收盘价
        "open": "6228.77"//开盘价
    },
    {
        "high": "6228.77",
        "vol": "222",
        "low": "6228.77",
        "idx": 1587632160,
        "close": "6228.77",
        "open": "6228.77"
    },
    {
        "high": "6228.77",
        "vol": "333",
        "low": "6228.77",
        "idx": 1587632100,
        "close": "6228.77",
        "open": "6228.77"
    }
]
```
# 交易相关
## 安全类型: TRADE
交易下方的接口都需要签名和API-KEY验证

## 创建订单
`GET` `https://futuresopenapi.xxx.com/fapi/v1/order`
#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数

| 字段            | 类型     | 是否必须 | 备注                          |
|---------------|--------|------|-----------------------------|
| volume        | number | 是    | 下单张数,市价开仓为价值.有精度限制,精度由管理员设置 |
| price         | number | 否    | 下单价格,限价单:必传,有精度限制,精度有管理员设置  |
| contractName  | string | 是    | 大写合约名称:`E-BTC-USDT`         |
| type          | string | 是    | 订单类型:`LIMIT/MARKET`         |
| side          | string | 是    | 买卖方向`BUY/SELL`              |
| open          | string | 是    | 开平仓方向`OPEN/CLOSE`           |
| positionType  | number | 否    | 持仓类型:`1:全仓/2:逐仓`            |
| clientOrderId | string | 否    | 客户端下单标识,长度小32位              |
| timeInForce   | string | 否    | `IOC,FOK,POST_ONLY`         |

> 响应:

```json
{
    "orderId": 256609229205684228//订单ID
}
```
## 创建条件单

`POST` `https://futuresopenapi.xxx.com/fapi/v1/conditionOrder/`
#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数

| 字段            | 类型     | 是否必须 | 备注                          |
|---------------|--------|------|-----------------------------|
| triggerType   | string | 是    | 条件单类型:`1:止损/2:止盈/3:追涨/4:杀跌` |     
| triggerPrice  | string | 是    | 触发价                         |     
| volume        | number | 是    | 下单张数,市价开仓为价值.有精度限制,精度由管理员设置 |
| price         | number | 否    | 下单价格,限价单:必传,有精度限制,精度有管理员设置  |
| contractName  | string | 是    | 大写合约名称:`E-BTC-USDT`         |
| type          | string | 是    | 订单类型:`LIMIT/MARKET`         |
| side          | string | 是    | 买卖方向`BUY/SELL`              |
| open          | string | 是    | 开平仓方向`OPEN/CLOSE`           |
| positionType  | number | 否    | 持仓类型:`1:全仓/2:逐仓`            |
| clientOrderId | string | 否    | 客户端下单标识,长度小32位              |

> 响应:

```json
{
    "code": "0",
    "msg": "Success",
    "data": {
        "triggerIds": [
            "1322738336974712847"//条件单ID
        ],
        "ids": [],
        "cancelIds": []
    },
    "succ": true
}
```
## 取消订单
`POST` `https://futuresopenapi.xxx.com/fapi/v1/cancel`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段           | 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| orderId      | string | 是    | 订单ID                |

> 响应:

```json
{
    "orderId": 256609229205684228//订单ID
}
```
## 订单详情
`GET` `https://futuresopenapi.xxx.com/fapi/v1/order`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段            | 类型     | 是否必须 | 备注                  |
|---------------|--------|------|---------------------|
| contractName  | string | 是    | 大写合约名称 `E-BTC-USDT` |
| orderId       | string | 是    | 订单ID                |
| clientOrderId | string | 否    | 客户端唯一标识             |

> 响应:

```json
{
    "side": "BUY",//订单方向
    "executedQty": 0,//成交数量
    "orderId": 2006628907041292645,//订单ID
    "price": 2000.0000000000000000,//委托价格
    "origQty": 2.0000000000000000,//委托数量
    "avgPrice": 0E-8,//成交均价
    "transactTime": 1704967622000,//订单创建时间
    "action": "OPEN",//OPEN/CLOSE
    "contractName": "E-BTC-USDT",//合约名称
    "type": "LIMIT",//订单类型
    "timeInForce": "",//条件单有效方式1 limit， 2 market，3 IOC，4 FOK，5 POST_ONLY
    "status": "NEW"//订单状态。可能出现的值为：NEW(新订单，无成交)、PARTIALLY_FILLED（部分成交）、FILLED（全部成交）、CANCELED（已取消）和REJECTED（订单被拒绝）
}
```
## 当前订单
`GET` `https://futuresopenapi.xxx.com/fapi/v1/openOrders`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段            | 类型     | 是否必须 | 备注                  |
|---------------|--------|------|---------------------|
| contractName  | string | 是    | 大写合约名称 `E-BTC-USDT` |

> 响应:

```json
[
    {
       "side": "BUY",//订单方向
       "executedQty": 0,//成交数量,可能出现的值只能为：BUY（买入做多） 和 SELL（卖出做空）
       "orderId": 259396989397942275,//订单ID
       "price": 10000.0000000000000000,//订单价格
       "origQty": 1.0000000000000000,//订单数量
       "avgPrice": 0E-8,//成交均价
       "transactTime": "1607702400000",//订单创建时间
       "action": "OPEN",//CLOSE/BUY
       "contractName": "E-BTC-USDT",//合约名称
       "type": "LIMIT",//订单类型。可能出现的值只能为:LIMIT(限价)和MARKET（市价）
       "status": "INIT"//订单状态。可能出现的值为：NEW(新订单，无成交)、PARTIALLY_FILLED（部分成交）、FILLED（全部成交）、CANCELED（已取消）和REJECTED（订单被拒绝）
    }
]
```
## 历史委托
`GET` `https://futuresopenapi.xxx.com/fapi/v1/orderHistorical`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段           | 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| limit        | string | 是    | 分页条数, 默认100; 最大1000 |
| fromId       | long   | 否    | 从这条记录开始检索           |

> 响应:

```json
[
    {
        "side":"BUY", //订单方向
        "clientId":"0",//客户端唯一标识
        "ctimeMs":1632903411000,//创建时间戳
        "positionType":2,//仓位类型,1:全仓/2:逐仓
        "orderId":777293886968070157,//订单ID
        "avgPrice":41000,//成交均价
        "openOrClose":"OPEN",//OPEN/CLOSE
        "leverageLevel":26,//杠杆倍数
        "type":4,//订单类型
        "closeTakerFeeRate":0.00065,//平仓taker手续费率
        "volume":2,//订单忽略
        "openMakerFeeRate":0.00025,//开仓maker手续费率
        "dealVolume":1,//成交数量
        "price":41000,//委托价格
        "closeMakerFeeRate":0.00025,//平台maker手续费率
        "contractId":1,//合约ID
        "ctime":"2021-09-29T16:16:51",//订单创建时间
        "contractName":"E-BTC-USDT",//合约名称
        "openTakerFeeRate":0.00065,//开仓taker手续费率
        "dealMoney":4.1,//成交价值
        "status":4 //订单状态
    }
]
```
## 盈亏记录
`GET` `https://futuresopenapi.xxx.com/fapi/v1/profitHistorical`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段           | 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| limit        | string | 是    | 分页条数, 默认100; 最大1000 |
| fromId       | long   | 否    | 从这条记录开始检索           |

> 响应:

```json
[
    {
        "side":"SELL",//仓位方向
        "positionType":2,//仓位类型,1:全仓/2:逐仓
        "tradeFee":-5.23575,//手续费
        "realizedAmount":0,//弃用
        "leverageLevel":26,//杠杆倍数
        "openPrice":44500,//开仓价格
        "settleProfit":0,//结算盈亏
        "mtime":1632882739000,//更新时间
        "shareAmount":0,//分摊金额
        "openEndPrice":44500,//开仓均价
        "closeProfit":-45,//平仓盈亏
        "volume":900,//仓位数量
        "contractId":1,//合约ID
        "historyRealizedAmount":-50.23575,//历史已实现盈亏
        "ctime":1632882691000,//创建时间戳
        "id":8764,//仓位ID
        "capitalFee":0 //资金费
    }
]

```
| 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| limit        | string | 是    | 分页条数, 默认100; 最大1000 |
| fromId       | long   | 否    | 从这条记录开始检索           |

> 响应:

```json
[
    {
        "side":"BUY", //订单方向
        "clientId":"0",//客户端唯一标识
        "ctimeMs":1632903411000,//创建时间戳
        "positionType":2,//仓位类型,1:全仓/2:逐仓
        "orderId":777293886968070157,//订单ID
        "avgPrice":41000,//成交均价
        "openOrClose":"OPEN",//OPEN/CLOSE
        "leverageLevel":26,//杠杆倍数
        "type":4,//订单类型
        "closeTakerFeeRate":0.00065,//平仓taker手续费率
        "volume":2,//订单忽略
        "openMakerFeeRate":0.00025,//开仓maker手续费率
        "dealVolume":1,//成交数量
        "price":41000,//委托价格
        "closeMakerFeeRate":0.00025,//平台maker手续费率
        "contractId":1,//合约ID
        "ctime":"2021-09-29T16:16:51",//订单创建时间
        "contractName":"E-BTC-USDT",//合约名称
        "openTakerFeeRate":0.00065,//开仓taker手续费率
        "dealMoney":4.1,//成交价值
        "status":4 //订单状态
    }
]
```
## 盈亏记录
`GET` `https://futuresopenapi.xxx.com/fapi/v1/profitHistorical`

#### 请求头

| 字段          | 类型     | 是否必须 | 备注        |
|-------------|--------|------|-----------|
| X-CH-TS     | string | 是    | 时间戳       |
| X-CH-APIKEY | string | 是    | 您的API-KEY |
| X-CH-SIGN   | string | 是    | 签名        |

#### 参数
| 字段           | 类型     | 是否必须 | 备注                  |
|--------------|--------|------|---------------------|
| contractName | string | 是    | 大写合约名称 `E-BTC-USDT` |
| limit        | string | 是    | 分页条数, 默认100; 最大1000 |
| fromId       | long   | 否    | 从这条记录开始检索           |

> 响应:

```json
[
    {
        "side":"SELL",//仓位方向
        "positionType":2,//仓位类型,1:全仓/2:逐仓
        "tradeFee":-5.23575,//手续费
        "realizedAmount":0,//弃用
        "leverageLevel":26,//杠杆倍数
        "openPrice":44500,//开仓价格
        "settleProfit":0,//结算盈亏
        "mtime":1632882739000,//更新时间
        "shareAmount":0,//分摊金额
        "openEndPrice":44500,//开仓均价
        "closeProfit":-45,//平仓盈亏
        "volume":900,//仓位数量
        "contractId":1,//合约ID
        "historyRealizedAmount":-50.23575,//历史已实现盈亏
        "ctime":1632882691000,//创建时间戳
        "id":8764,//仓位ID
        "capitalFee":0 //资金费
    }
]

```