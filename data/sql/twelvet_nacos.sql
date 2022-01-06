-- Nacos配置


-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 205 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (5, 'twelvet-app-dev.yml', 'DEFAULT_GROUP', '# 服务调用超时时间(ms)\nribbon:\n  ReadTimeout: 8000\n  ConnectTimeout: 8000\n\n# 认证配置\nsecurity:\n  oauth2:\n    # 配置Resource Client_id信息\n    client:\n      client-id: twelvet\n      client-secret: 123456\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://twelvet-auth/oauth/check_token\n    ignore:\n      urls:\n        - /actuator/**\n        - /v2/api-docs\nspring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  jackson:\n    default-property-inclusion: non_null\n    time-zone: GMT+8\n  cloud:\n    # 配置sentinel控制台\n    sentinel:\n      # 取消控制台懒加载\n      eager: true\n      transport:\n        # 控制台地址：Port端口\n        dashboard: 127.0.0.1:8718\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# Mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.twelvet.api.*.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath*:mapper/**/*Mapper.xml\n  # Mybatis开启日志打印\n  configuration:\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n\n# 分布式事务配置\nseata:\n  # 未配置分布式事务,不要打开,会报错，且spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  application-id: ${twelvet.name}\n  # 事务分组,nacos配置上必须相对应的配置\n  tx-service-group: ${twelvet.name}-group\n  # 开启自动数据源代理\n  enable-auto-data-source-proxy: true\n  config:\n    type: nacos\n    nacos:\n      server-addr: http://nacos.io\n      namespace: 60ca01e2-221e-47af-b7e5-64f2a7336973\n      group: DEFAULT_GROUP\n  registry:\n    type: nacos\n    nacos:\n      server-addr: http://nacos.io\n      application: seata-server\n      group: DEFAULT_GROUP\n      namespace: 60ca01e2-221e-47af-b7e5-64f2a7336973\n      cluster: DEFAULT\n\n# Swagger\nknife4j:\n  # 开启生产环境关闭Swagger\n  production: false\n', '0ef14e0f626b287894c7f5397cea7c85', '2020-06-04 12:38:30', '2021-08-23 04:44:42', '2471835953', '119.129.228.23', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '公共配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (18, 'twelvet-auth-dev.yml', 'DEFAULT_GROUP', 'spring: \r\n  # 模板引擎配置\r\n  freemarker:\r\n    # 后缀名\r\n    suffix: .ftl  \r\n    content-type: text/html\r\n    enabled: true\r\n    # 缓存配置\r\n    cache: false \r\n    # 模板加载路径 按需配置\r\n    template-loader-path: classpath:/templates/ \r\n    charset: UTF-8\r\n  datasource:\r\n    dynamic:\r\n      # 设置默认的数据源或者数据源组,默认值即为master\r\n      primary: master \r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n        # 主库数据源\r\n        master:\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\r\n          username: twelvet\r\n          password: 123456\r\n        # 从库数据源\r\n        # slave:\r\n        # username:\r\n        # password:\r\n        # url:\r\n        # driver-class-name:\r\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\r\n      seata: false\r\n  redis:\r\n    host: 127.0.0.1\r\n    port: 6379\r\n    password: 123456\r\n    # 连接超时时间\r\n    timeout: 30s\r\n    lettuce:\r\n      pool:\r\n        # 连接池中的最小空闲连接\r\n        min-idle: 0\r\n        # 连接池中的最大空闲连接\r\n        max-idle: 8\r\n        # 连接池的最大数据库连接数\r\n        max-active: 8\r\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\r\n        max-wait: -1ms\r\nswagger:\r\n  title: TwelveT Swagger API\r\n  version: 2.0.0\r\n  description: 授权中心服务\r\n  license: Powered By TwelveT\r\n  licenseUrl: https://www.twelvet.cn\r\n  terms-of-service-url: https://www.twelvet.cn\r\n  contact:\r\n    name: TwelveT\r\n    email: 2471835953@qq.com\r\n    url: https://www.twelvet.cn\r\n  authorization:\r\n    name: password\r\n    token-url-list:\r\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token', 'fa0ba9285e3d1d4988fad4fb468d5f7b', '2020-06-07 19:45:01', '2021-08-07 22:41:30', NULL, '223.104.67.33', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '认证服务器配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (19, 'twelvet-server-system-dev.yml', 'DEFAULT_GROUP', 'spring: \r\n  datasource:\r\n    dynamic:\r\n      # 设置默认的数据源或者数据源组,默认值即为master\r\n      primary: master \r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n        # 主库数据源\r\n        master:\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\r\n          username: twelvet\r\n          password: 123456\r\n        # 从库数据源\r\n        # slave:\r\n        # username:\r\n        # password:\r\n        # url:\r\n        # driver-class-name:\r\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\r\n      seata: false\r\n  redis:\r\n    host: 127.0.0.1\r\n    port: 6379\r\n    password: 123456\r\n    # 连接超时时间\r\n    timeout: 30s\r\n    lettuce:\r\n      pool:\r\n        # 连接池中的最小空闲连接\r\n        min-idle: 0\r\n        # 连接池中的最大空闲连接\r\n        max-idle: 8\r\n        # 连接池的最大数据库连接数\r\n        max-active: 8\r\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\r\n        max-wait: -1ms\r\n\r\nswagger:\r\n  title: TwelveT Swagger API\r\n  version: 2.0.0\r\n  description: 系统服务\r\n  license: Powered By TwelveT\r\n  licenseUrl: https://www.twelvet.cn\r\n  terms-of-service-url: https://www.twelvet.cn\r\n  contact:\r\n    name: TwelveT\r\n    email: 2471835953@qq.com\r\n    url: https://www.twelvet.cn\r\n  authorization:\r\n    name: password\r\n    token-url-list:\r\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\r\n# 开启Swagger增强模式\r\nknife4j:\r\n  enable: true', '87e66e857043c7c75feccb71e239d129', '2020-06-07 19:45:29', '2021-08-07 22:40:08', NULL, '223.104.67.33', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '系统模块', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (41, 'twelvet-gateway-dev.yml', 'DEFAULT_GROUP', 'spring: \n  cloud:\n    gateway:\n      globalcors:\n        corsConfigurations:\n          \'[/**]\':\n            allowedOriginPatterns: \"*\"\n            allowed-methods: \"*\"\n            allowed-headers: \"*\"\n            allow-credentials: true\n            exposedHeaders: \"Content-Disposition,Content-Type,Cache-Control\"\n      loadbalancer: \n        use404: true\n      discovery:\n        locator:\n          # 开启服务名称小写匹配\n          lowerCaseServiceId: true\n          # 开启动态创建路由（不用每个都写死）\n          enabled: true\n      # 路由配置\n      routes:\n        # 认证中心\n        - id: twelvet-auth\n          uri: lb://twelvet-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: twelvet-server-system\n          # 匹配后提供服务的路由地址\n          uri: lb://twelvet-server-system\n           # 断言，路径匹配的进行路由\n          predicates:\n            - Path=/system/**\n          filters:\n            # 转发请求时去除路由前缀（system）\n            - StripPrefix=1\n            # 请求重写，将内部开放服务重写(重要配置，请勿轻易修改，否则将暴露用户信息API)\n            - RewritePath=/user/info(?<segment>/?.*), /from-user-info$\\{segment}\n        # 定时任务\n        - id: twelvet-server-job\n          uri: lb://twelvet-server-job\n          predicates:\n            - Path=/job/**\n          filters:\n            - StripPrefix=1\n        # DFS文件系统\n        - id: twelvet-server-dfs\n          uri: lb://twelvet-server-dfs\n          predicates:\n            - Path=/dfs/**\n          filters:\n            - StripPrefix=1\n            # 请求重写，不允许直接上传文件\n            - RewritePath=/upload(?<segment>/?.*), /from-upload$\\{segment}\n        # 代码生成器\n        - id: twelvet-server-gen\n          uri: lb://twelvet-server-gen\n          predicates:\n            - Path=/gen/**\n          filters:\n            - StripPrefix=1\n\n# 防止xss攻击\nsecurity:\n  xss:\n    enabled: true\n    excludeUrls: \n      ', 'a97383c90b3773f21dc295eec223fe43', '2020-06-12 11:46:10', '2021-09-03 20:15:06', '2471835953', '223.104.67.22', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '网关配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (105, 'twelvet-monitor-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: twelvet\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: TwelveT服务监控中心', '315056a443f809904b98f0184580cbce', '2020-09-06 23:43:00', '2021-07-04 18:26:02', NULL, '223.104.67.29', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '服务监控中心', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (109, 'sentinel-twelvet-gateway', 'DEFAULT_GROUP', '[\r\n    {\r\n        \"resource\": \"twelvet-auth\",\r\n        \"count\": 10,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"twelvet-system\",\r\n        \"count\": 10,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]', '2197166e05df7bbfde1019b539977de7', '2020-09-07 20:50:09', '2021-04-24 23:36:00', NULL, '117.136.32.221', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '流量控制', 'null', 'null', 'json', 'null');
INSERT INTO `config_info` VALUES (130, 'twelvet-server-job-dev.yml', 'DEFAULT_GROUP', '# Spring\r\nspring: \r\n  datasource:\r\n    dynamic:\r\n      # 设置默认的数据源或者数据源组,默认值即为master\r\n      primary: master \r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n        # 主库数据源\r\n        master:\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://127.0.0.1:3306/twelvet_job?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\r\n          username: twelvet\r\n          password: 123456\r\n        # 从库数据源\r\n        # slave:\r\n        # username:\r\n        # password:\r\n        # url:\r\n        # driver-class-name:\r\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\r\n      seata: false\r\n  \r\nswagger:\r\n  title: TwelveT Swagger API\r\n  version: 2.0.0\r\n  description: 分布式调度服务\r\n  license: Powered By TwelveT\r\n  licenseUrl: https://www.twelvet.cn\r\n  terms-of-service-url: https://www.twelvet.cn\r\n  contact:\r\n    name: TwelveT\r\n    email: 2471835953@qq.com\r\n    url: https://www.twelvet.cn\r\n  authorization:\r\n    name: twelvet\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: server all\r\n    token-url-list:\r\n      - http://${GATEWAY_HOST:twelvet-gateway}:${GATEWAY_PORT:88}/auth/oauth/token\r\n# 开启Swagger增强模式\r\nknife4j:\r\n  enable: true', '4a54baeee3f8054ee6c4e23579abca45', '2020-11-03 15:47:23', '2021-05-03 11:06:00', NULL, '120.231.57.22', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '分布式定时任务配置', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (155, 'twelvet-server-dfs-dev.yml', 'DEFAULT_GROUP', 'spring: \r\n  datasource:\r\n   dynamic:\r\n      # 设置默认的数据源或者数据源组,默认值即为master\r\n      primary: master \r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n        # 主库数据源\r\n        master:\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\r\n          username: twelvet\r\n          password: 123456\r\n        # 从库数据源\r\n        # slave:\r\n        # username:\r\n        # password:\r\n        # url:\r\n        # driver-class-name:\r\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\r\n      seata: false\r\n\r\n# FastDFS配置\r\nfdfs:\r\n  domain: http://cloud.twelvet.cn/dfs\r\n  soTimeout: 3000\r\n  connectTimeout: 2000\r\n  trackerList: 127.0.0.1:22122\r\n\r\nswagger:\r\n  title: TwelveT Swagger API\r\n  version: 2.0.0\r\n  description: DFS服务\r\n  license: Powered By TwelveT\r\n  licenseUrl: https://www.twelvet.cn\r\n  terms-of-service-url: https://www.twelvet.cn\r\n  contact:\r\n    name: TwelveT\r\n    email: 2471835953@qq.com\r\n    url: https://www.twelvet.cn\r\n  authorization:\r\n    name: password\r\n    token-url-list:\r\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\r\n# 开启Swagger增强模式\r\nknife4j:\r\n  enable: true', '770c3b084d1ea3ced5fc0f98f99d6513', '2020-12-13 18:42:02', '2021-05-03 11:06:27', NULL, '120.231.57.22', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '分布式文件系统', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (226, 'store.mode', 'DEFAULT_GROUP', 'db', 'd77d5e503ad1439f585ac494268b351b', '2021-03-10 14:55:40', '2021-03-10 14:55:40', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (227, 'store.db.datasource', 'DEFAULT_GROUP', 'druid', '3d650fb8a5df01600281d48c47c9fa60', '2021-03-10 14:55:40', '2021-03-10 14:55:40', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (228, 'store.db.dbType', 'DEFAULT_GROUP', 'mysql', '81c3b080dad537de7e10e0987a4bf52e', '2021-03-10 14:55:41', '2021-03-10 14:55:41', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (229, 'store.db.driverClassName', 'DEFAULT_GROUP', 'com.mysql.jdbc.Driver', '683cf0c3a5a56cec94dfac94ca16d760', '2021-03-10 14:55:41', '2021-03-10 14:55:41', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (230, 'store.db.url', 'DEFAULT_GROUP', 'jdbc:mysql://127.0.0.1:3306/twelvet_seata?useUnicode=true', 'afaf8f99e8c60ca2837ae6e54ffbfb8e', '2021-03-10 14:55:41', '2021-03-10 14:59:51', NULL, '117.136.31.81', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', 'null', 'null', 'null', 'null', 'null');
INSERT INTO `config_info` VALUES (231, 'store.db.user', 'DEFAULT_GROUP', 'twelvet', 'b08b1d0e53062cd03513b2fde5488e2f', '2021-03-10 14:55:42', '2021-03-10 14:59:21', NULL, '117.136.31.81', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', 'null', 'null', 'null', 'null', 'null');
INSERT INTO `config_info` VALUES (232, 'store.db.password', 'DEFAULT_GROUP', '123456', 'd3e297a95855225cc7cf5494c92b7f0b', '2021-03-10 14:55:42', '2021-03-10 14:57:53', NULL, '117.136.31.81', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', 'null', 'null', 'null', 'null', 'null');
INSERT INTO `config_info` VALUES (233, 'store.db.minConn', 'DEFAULT_GROUP', '5', 'e4da3b7fbbce2345d7772b0674a318d5', '2021-03-10 14:55:42', '2021-03-10 14:55:42', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (234, 'store.db.maxConn', 'DEFAULT_GROUP', '30', '34173cb38f07f89ddbebc2ac9128303f', '2021-03-10 14:55:42', '2021-03-10 14:55:42', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (235, 'store.db.globalTable', 'DEFAULT_GROUP', 'global_table', '8b28fb6bb4c4f984df2709381f8eba2b', '2021-03-10 14:55:43', '2021-03-10 14:55:43', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (236, 'store.db.branchTable', 'DEFAULT_GROUP', 'branch_table', '54bcdac38cf62e103fe115bcf46a660c', '2021-03-10 14:55:43', '2021-03-10 14:55:43', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (237, 'store.db.queryLimit', 'DEFAULT_GROUP', '100', 'f899139df5e1059396431415e770c6dd', '2021-03-10 14:55:43', '2021-03-10 14:55:43', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (238, 'store.db.lockTable', 'DEFAULT_GROUP', 'lock_table', '55e0cae3b6dc6696b768db90098b8f2f', '2021-03-10 14:55:44', '2021-03-10 14:55:44', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (239, 'store.db.maxWait', 'DEFAULT_GROUP', '5000', 'a35fe7f7fe8217b4369a0af4244d1fca', '2021-03-10 14:55:44', '2021-03-10 14:55:44', NULL, '127.0.0.1', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `config_info` VALUES (246, 'service.vgroupMapping.twelvet-system-group', 'DEFAULT_GROUP', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2021-03-10 16:03:54', '2021-03-10 16:03:54', NULL, '117.136.31.81', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, 'text', NULL);
INSERT INTO `config_info` VALUES (247, 'service.vgroupMapping.twelvet-dfs-group', 'DEFAULT_GROUP', 'default', 'c21f969b5f03d33d43e04f8f136e7682', '2021-03-10 16:27:41', '2021-03-10 16:27:41', NULL, '117.136.31.81', '', '60ca01e2-221e-47af-b7e5-64f2a7336973', NULL, NULL, NULL, 'text', NULL);
INSERT INTO `config_info` VALUES (301, 'twelvet-server-gen-dev.yml', 'DEFAULT_GROUP', '# spring配置\r\nspring: \r\n  datasource:\r\n    dynamic:\r\n      # 设置默认的数据源或者数据源组,默认值即为master\r\n      primary: master \r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n        # 主库数据源\r\n        master:\r\n          driver-class-name: com.mysql.cj.jdbc.Driver\r\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\r\n          username: twelvet\r\n          password: 123456\r\n        # 从库数据源\r\n        # slave:\r\n        # username:\r\n        # password:\r\n        # url:\r\n        # driver-class-name:\r\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\r\n      seata: false\r\n  redis:\r\n    host: 47.107.77.38\r\n    port: 6379\r\n    password: \r\n    # 连接超时时间\r\n    timeout: 30s\r\n    lettuce:\r\n      pool:\r\n        # 连接池中的最小空闲连接\r\n        min-idle: 0\r\n        # 连接池中的最大空闲连接\r\n        max-idle: 8\r\n        # 连接池的最大数据库连接数\r\n        max-active: 8\r\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\r\n        max-wait: -1ms\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: TwelveT\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.twelvet.server.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n\r\nswagger:\r\n  title: TwelveT Swagger API\r\n  version: 2.0.0\r\n  description: CRUD服务\r\n  license: Powered By TwelveT\r\n  licenseUrl: https://www.twelvet.cn\r\n  terms-of-service-url: https://www.twelvet.cn\r\n  contact:\r\n    name: TwelveT\r\n    email: 2471835953@qq.com\r\n    url: https://www.twelvet.cn\r\n  authorization:\r\n    name: password\r\n    token-url-list:\r\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\r\n# 开启Swagger增强模式\r\nknife4j:\r\n  enable: true', '30604e8e9d726b276a266e74c7409b43', '2021-03-20 13:04:24', '2021-05-03 11:08:34', NULL, '120.231.57.22', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '代码生成器', 'null', 'null', 'yaml', 'null');
INSERT INTO `config_info` VALUES (392, 'twelvet-app-pro.yml', 'DEFAULT_GROUP', '# 服务调用超时时间(ms)\nribbon:\n  ReadTimeout: 8000\n  ConnectTimeout: 8000\n\n# 认证配置\nsecurity:\n  oauth2:\n    # 配置Resource Client_id信息\n    client:\n      client-id: twelvet\n      client-secret: 123456\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://twelvet-auth/oauth/check_token\n    ignore:\n      urls:\n        - /actuator/**\n        - /v2/api-docs\nspring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  jackson:\n    default-property-inclusion: non_null\n    time-zone: GMT+8\n  cloud:\n    # 配置sentinel控制台\n    sentinel:\n      # 取消控制台懒加载\n      eager: true\n      transport:\n        # 控制台地址：Port端口\n        dashboard: 127.0.0.1:8718\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n# Mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.twelvet.api.*.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath*:mapper/**/*Mapper.xml\n  # Mybatis开启日志打印\n  configuration:\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n\n# 分布式事务配置\nseata:\n  # 未配置分布式事务,不要打开,会报错，且spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  application-id: ${twelvet.name}\n  # 事务分组,nacos配置上必须相对应的配置\n  tx-service-group: ${twelvet.name}-group\n  # 开启自动数据源代理\n  enable-auto-data-source-proxy: true\n  config:\n    type: nacos\n    nacos:\n      server-addr: http://nacos.io\n      namespace: 60ca01e2-221e-47af-b7e5-64f2a7336973\n      group: DEFAULT_GROUP\n  registry:\n    type: nacos\n    nacos:\n      server-addr: http://nacos.io\n      application: seata-server\n      group: DEFAULT_GROUP\n      namespace: 60ca01e2-221e-47af-b7e5-64f2a7336973\n      cluster: DEFAULT\n\n# Swagger\nknife4j:\n  # 开启生产环境关闭Swagger\n  production: false\n', '0ef14e0f626b287894c7f5397cea7c85', '2021-09-17 20:48:24', '2021-09-18 03:23:45', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (393, 'twelvet-auth-pro.yml', 'DEFAULT_GROUP', 'spring: \n  # 模板引擎配置\n  freemarker:\n    # 后缀名\n    suffix: .ftl  \n    content-type: text/html\n    enabled: true\n    # 缓存配置\n    cache: false \n    # 模板加载路径 按需配置\n    template-loader-path: classpath:/templates/ \n    charset: UTF-8\n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为master\n      primary: master \n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,wall,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\n          username: twelvet\n          password: 123456\n        # 从库数据源\n        # slave:\n        # username:\n        # password:\n        # url:\n        # driver-class-name:\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\n      seata: false\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456\n    # 连接超时时间\n    timeout: 30s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\nswagger:\n  title: TwelveT Swagger API\n  version: 2.0.0\n  description: 授权中心服务\n  license: Powered By TwelveT\n  licenseUrl: https://www.twelvet.cn\n  terms-of-service-url: https://www.twelvet.cn\n  contact:\n    name: TwelveT\n    email: 2471835953@qq.com\n    url: https://www.twelvet.cn\n  authorization:\n    name: password\n    token-url-list:\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token', '2fb15266ca004fbf9024e859ba2751dc', '2021-09-17 20:48:24', '2021-09-18 03:23:52', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (394, 'twelvet-server-system-pro.yml', 'DEFAULT_GROUP', 'spring: \n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为master\n      primary: master \n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,wall,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\n          username: twelvet\n          password: 123456\n        # 从库数据源\n        # slave:\n        # username:\n        # password:\n        # url:\n        # driver-class-name:\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\n      seata: false\n  redis:\n    host: 127.0.0.1\n    port: 6379\n    password: 123456\n    # 连接超时时间\n    timeout: 30s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\nswagger:\n  title: TwelveT Swagger API\n  version: 2.0.0\n  description: 系统服务\n  license: Powered By TwelveT\n  licenseUrl: https://www.twelvet.cn\n  terms-of-service-url: https://www.twelvet.cn\n  contact:\n    name: TwelveT\n    email: 2471835953@qq.com\n    url: https://www.twelvet.cn\n  authorization:\n    name: password\n    token-url-list:\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\n# 开启Swagger增强模式\nknife4j:\n  enable: true', 'e11e8ed4d1d86004146dc276e621a41c', '2021-09-17 20:48:24', '2021-09-18 03:23:37', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (395, 'twelvet-gateway-pro.yml', 'DEFAULT_GROUP', 'spring: \n  cloud:\n    gateway:\n      globalcors:\n        corsConfigurations:\n          \'[/**]\':\n            allowedOriginPatterns: \"*\"\n            allowed-methods: \"*\"\n            allowed-headers: \"*\"\n            allow-credentials: true\n            exposedHeaders: \"Content-Disposition,Content-Type,Cache-Control\"\n      loadbalancer: \n        use404: true\n      discovery:\n        locator:\n          # 开启服务名称小写匹配\n          lowerCaseServiceId: true\n          # 开启动态创建路由（不用每个都写死）\n          enabled: true\n      # 路由配置\n      routes:\n        # 认证中心\n        - id: twelvet-auth\n          uri: lb://twelvet-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: twelvet-server-system\n          # 匹配后提供服务的路由地址\n          uri: lb://twelvet-server-system\n           # 断言，路径匹配的进行路由\n          predicates:\n            - Path=/system/**\n          filters:\n            # 转发请求时去除路由前缀（system）\n            - StripPrefix=1\n            # 请求重写，将内部开放服务重写(重要配置，请勿轻易修改，否则将暴露用户信息API)\n            - RewritePath=/user/info(?<segment>/?.*), /from-user-info$\\{segment}\n        # 定时任务\n        - id: twelvet-server-job\n          uri: lb://twelvet-server-job\n          predicates:\n            - Path=/job/**\n          filters:\n            - StripPrefix=1\n        # DFS文件系统\n        - id: twelvet-server-dfs\n          uri: lb://twelvet-server-dfs\n          predicates:\n            - Path=/dfs/**\n          filters:\n            - StripPrefix=1\n            # 请求重写，不允许直接上传文件\n            - RewritePath=/upload(?<segment>/?.*), /from-upload$\\{segment}\n        # 代码生成器\n        - id: twelvet-server-gen\n          uri: lb://twelvet-server-gen\n          predicates:\n            - Path=/gen/**\n          filters:\n            - StripPrefix=1\n\n# 防止xss攻击\nsecurity:\n  xss:\n    enabled: true\n    excludeUrls: \n      ', 'a97383c90b3773f21dc295eec223fe43', '2021-09-17 20:48:24', '2021-09-18 03:23:59', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (396, 'twelvet-monitor-pro.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  security:\n    user:\n      name: twelvet\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: TwelveT服务监控中心', 'f3fc4e54e1ab2039ae1647cddd319724', '2021-09-17 20:48:24', '2021-09-18 03:24:05', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (397, 'sentinel-twelvet-gateway', 'DEFAULT_GROUP', '[\n    {\n        \"resource\": \"twelvet-auth\",\n        \"count\": 10,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"twelvet-system\",\n        \"count\": 10,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    }\n]', '423c02800c2fd5f5540c063edf82106f', '2021-09-17 20:48:24', '2021-09-18 03:24:11', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'text', '');
INSERT INTO `config_info` VALUES (398, 'twelvet-server-job-pro.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为master\n      primary: master \n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,wall,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://127.0.0.1:3306/twelvet_job?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\n          username: twelvet\n          password: 123456\n        # 从库数据源\n        # slave:\n        # username:\n        # password:\n        # url:\n        # driver-class-name:\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\n      seata: false\n  \nswagger:\n  title: TwelveT Swagger API\n  version: 2.0.0\n  description: 分布式调度服务\n  license: Powered By TwelveT\n  licenseUrl: https://www.twelvet.cn\n  terms-of-service-url: https://www.twelvet.cn\n  contact:\n    name: TwelveT\n    email: 2471835953@qq.com\n    url: https://www.twelvet.cn\n  authorization:\n    name: twelvet\n    auth-regex: ^.*$\n    authorization-scope-list:\n      - scope: server\n        description: server all\n    token-url-list:\n      - http://${GATEWAY_HOST:twelvet-gateway}:${GATEWAY_PORT:88}/auth/oauth/token\n# 开启Swagger增强模式\nknife4j:\n  enable: true', '36a35a700ebce615d0758e118cd5f92f', '2021-09-17 20:48:24', '2021-09-18 03:24:17', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (399, 'twelvet-server-dfs-pro.yml', 'DEFAULT_GROUP', 'spring: \n  datasource:\n   dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为master\n      primary: master \n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,wall,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\n          username: twelvet\n          password: 123456\n        # 从库数据源\n        # slave:\n        # username:\n        # password:\n        # url:\n        # driver-class-name:\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\n      seata: false\n\n# FastDFS配置\nfdfs:\n  domain: http://cloud.twelvet.cn/dfs\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 127.0.0.1:22122\n\nswagger:\n  title: TwelveT Swagger API\n  version: 2.0.0\n  description: DFS服务\n  license: Powered By TwelveT\n  licenseUrl: https://www.twelvet.cn\n  terms-of-service-url: https://www.twelvet.cn\n  contact:\n    name: TwelveT\n    email: 2471835953@qq.com\n    url: https://www.twelvet.cn\n  authorization:\n    name: password\n    token-url-list:\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\n# 开启Swagger增强模式\nknife4j:\n  enable: true', '36feb67db0108e7d280d158684b50fbb', '2021-09-17 20:48:24', '2021-09-18 03:24:26', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (400, 'twelvet-server-gen-pro.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  datasource:\n    dynamic:\n      # 设置默认的数据源或者数据源组,默认值即为master\n      primary: master \n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,wall,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://127.0.0.1:3306/twelvet?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8\n          username: twelvet\n          password: 123456\n        # 从库数据源\n        # slave:\n        # username:\n        # password:\n        # url:\n        # driver-class-name:\n      # 开启seata代理，开启后默认每个数据源都代理,分布式事务必须开启,否则关闭\n      seata: false\n  redis:\n    host: 47.107.77.38\n    port: 6379\n    password: \n    # 连接超时时间\n    timeout: 30s\n    lettuce:\n      pool:\n        # 连接池中的最小空闲连接\n        min-idle: 0\n        # 连接池中的最大空闲连接\n        max-idle: 8\n        # 连接池的最大数据库连接数\n        max-active: 8\n        # #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-wait: -1ms\n\n# 代码生成\ngen: \n  # 作者\n  author: TwelveT\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.twelvet.server.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n\nswagger:\n  title: TwelveT Swagger API\n  version: 2.0.0\n  description: CRUD服务\n  license: Powered By TwelveT\n  licenseUrl: https://www.twelvet.cn\n  terms-of-service-url: https://www.twelvet.cn\n  contact:\n    name: TwelveT\n    email: 2471835953@qq.com\n    url: https://www.twelvet.cn\n  authorization:\n    name: password\n    token-url-list:\n      - http://${GATEWAY_HOST:localhost}:${GATEWAY_PORT:88}/auth/oauth/token\n# 开启Swagger增强模式\nknife4j:\n  enable: true', '0e42cac429b699192fdca64266116342', '2021-09-17 20:48:24', '2021-09-18 03:24:33', '2471835953', '116.21.223.180', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (410, 'twelvet-mail-dev.yml', 'DEFAULT_GROUP', 'spring:\n  mail:\n    host: smtp.qq.com\n    # 发送者邮箱\n    username: 2471835953@qq.com\n    # 配置密码(注意不是真正的密码，而是申请到的授权码)\n    password: 123456\n    # 端口号465或587\n    port: 587\n    # 默认的邮件编码为UTF-8\n    default-encoding: UTF-8\n    # 配置SSL 加密工厂\n    properties:\n      mail:\n        smtp:\n          socketFactoryClass: javax.net.ssl.SSLSocketFactory\n        #表示开启 DEBUG 模式，这样，邮件发送过程的日志会在控制台打印出来，方便排查错误\n        debug: false', '0135a9a842548fc4b69e162b1ae8a413', '2021-09-20 09:43:16', '2021-09-20 19:49:55', '2471835953', '223.104.67.93', '', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (411, 'twelvet-mail-pro.yml', 'DEFAULT_GROUP', 'spring:\n  mail:\n    host: smtp.qq.com\n    # 发送者邮箱\n    username: 2471835953@qq.com\n    # 配置密码(注意不是真正的密码，而是申请到的授权码)\n    password: 123456\n    # 端口号465或587\n    port: 587\n    # 默认的邮件编码为UTF-8\n    default-encoding: UTF-8\n    # 配置SSL 加密工厂\n    properties:\n      mail:\n        smtp:\n          socketFactoryClass: javax.net.ssl.SSLSocketFactory\n        #表示开启 DEBUG 模式，这样，邮件发送过程的日志会在控制台打印出来，方便排查错误\n        debug: false', '0135a9a842548fc4b69e162b1ae8a413', '2021-09-20 09:44:43', '2021-09-20 19:50:09', '2471835953', '223.104.67.93', '', '94664454-62b0-415a-9392-7c0ce2d11b2f', '', '', '', 'yaml', '');


-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT '2010-05-05 00:00:00' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (1, '1', 'eeb43899-8a88-4f5b-b0e0-d7c8fd09b86e', 'dev', '开发环境', 'nacos', 1591243291556, 1591243291556);
INSERT INTO `tenant_info` VALUES (2, '1', '1edbee6b-43a7-4b97-a0f7-2804a8bb1bf9', 'test', '测试环境', 'nacos', 1598779661839, 1598779661839);
INSERT INTO `tenant_info` VALUES (4, '1', 'c4d16870-3d8d-40a8-b396-6737705dbde8', 'pre', '灰度环境', 'nacos', 1598779690682, 1598779690682);
INSERT INTO `tenant_info` VALUES (5, '1', '94664454-62b0-415a-9392-7c0ce2d11b2f', 'pro', '生产环境', 'nacos', 1598779700041, 1598779700041);
INSERT INTO `tenant_info` VALUES (6, '1', '60ca01e2-221e-47af-b7e5-64f2a7336973', 'seata', '分布式事务', 'nacos', 1615359228918, 1615359228918);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;