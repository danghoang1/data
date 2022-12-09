#!/bin/bash
bash <(curl -Ls https://raw.githubusercontent.com/AikoXrayR-Project/AikoXrayR-install/master/install.sh)
read -p " ID NODE Cổng 80: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " ID NODE Cổng 443: " node_id2
  [ -z "${node_id2}" ] && node_id2=0
  
read -p "CertDomain: " CertDomain
  [ -z "${CertDomain}" ] && CertDomain="0"
  
cd /etc/XrayR
cat >crt.crt <<EOF
điền ssl crt
EOF
cat >key.key <<EOF
 điền ssl key
EOF
cat >config.yml <<EOF
Log:
  Level: none 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json
InboundConfigPath: # /etc/XrayR/custom_inbound.json
RouteConfigPath: # /etc/XrayR/route.json
OutboundConfigPath: # /etc/XrayR/custom_outbound.json
ConnetionConfig:
  Handshake: 4 
  ConnIdle: 30 
  UplinkOnly: 2 
  DownlinkOnly: 4 
  BufferSize: 64 
Nodes:
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://domain"
      ApiKey: "123"
      NodeID1: 29
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0 
      DeviceLimit: 2 
      RuleListPath: # /etc/XrayR/rulelist
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 
      SendIP: 0.0.0.0 
      UpdatePeriodic: 60 
      EnableDNS: false 
      DNSType: AsIs 
      EnableProxyProtocol: false 
      EnableFallback: false 
      FallBackConfigs:  
        -
          SNI: 
          Path: 
          Dest: 80 
          ProxyProtocolVer: 0 
      CertConfig:
        CertMode: none 
        CertDomain: "subdomain" 
        CertFile: /etc/XrayR/cert/node1.test.com.cert 
        KeyFile: /etc/XrayR/cert/node1.test.com.key
        Provider: alidns 
        Email: test@me.com
        DNSEnv: 
          ALICLOUD_ACCESS_KEY: aaa
          ALICLOUD_SECRET_KEY: bbb
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://doamin"
      ApiKey: "123"
      NodeID2: 30
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0 
      DeviceLimit: 2 
      RuleListPath: # /etc/XrayR/rulelist
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 
      SendIP: 0.0.0.0 
      UpdatePeriodic: 60 
      EnableDNS: false 
      DNSType: AsIs 
      EnableProxyProtocol: false 
      EnableFallback: false 
      FallBackConfigs:  
        -
          SNI: 
          Path: 
          Dest: 80 
          ProxyProtocolVer: 0 
      CertConfig:
        CertMode: file 
        CertDomain2: "subdomain " 
        CertFile: /etc/XrayR/abc.crt 
        KeyFile: /etc/XrayR/abc.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: 
          CLOUDFLARE_EMAIL: 
          CLOUDFLARE_API_KEY: 
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./config.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./config.yml
sed -i "s|CertDomain2:.*|CertDomain: \"${CertDomain}\"|" ./config.yml
cd /root
xrayr restart
