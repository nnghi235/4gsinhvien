#! /bin/bash
function install(){
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)
clear
echo -e "   Cài Đặt XrayR Hoàn Tất !"
}
function config(){
clear
read -p " NODE ID 1: " node_id1
  [ -z "${node_id1}" ] && node_id1=0
  
read -p " NODE ID 2: " node_id2
  [ -z "${node_id2}" ] && node_id2=0
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/XrayR/4gsinhvien.crt -keyout /etc/XrayR/4gsinhvien.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
cd /etc/XrayR
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
      ApiHost: "https://4gsinhvien.me"
      ApiKey: "duongdinhtai2004"
      NodeID1: 1
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0 
      DeviceLimit: 0
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
        CertDomain: "vn.speed4g.me" 
        CertFile: /etc/XrayR/4gsinhvien.crt
        KeyFile: /etc/XrayR/4gsinhvien.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: 
          CLOUDFLARE_EMAIL:
          CLOUDFLARE_API_KEY:
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://4gsinhvien.me"
      ApiKey: "duongdinhtai2004"
      NodeID2: 1
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0 
      DeviceLimit: 0
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
        CertDomain: "vn.speed4g.me" 
        CertFile: /etc/XrayR/4gsinhvien.crt 
        KeyFile: /etc/XrayR/4gsinhvien.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: 
          CLOUDFLARE_EMAIL: 
          CLOUDFLARE_API_KEY: 
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./config.yml
sed -i "s|NodeID2:.*|NodeID: ${node_id2}|" ./config.yml
cd /root
clear
xrayr restart
}
function view(){
nano /etc/XrayR/config.yml
}
function log(){
xrayr log
}
function restart(){
xrayr restart
}
function uninstall(){
xrayr uninstall
}
function start_menu(){
    clear
    echo -e "   1. Cài Đặt XrayR"
    echo -e "   2. Cài Đặt Nút"
    echo -e "   3. Xem Config"
    echo -e "   4. Xem Log"
    echo -e "   5. Khởi Động Lại XrayR"
    echo -e "   6. Gỡ Cài Đặt XrayR"
    read -p "Vui Lòng Chọn:" numrun
    case "$numrun" in
        1 )
           install
	    ;;
        2 )
           config
        ;;
        3 )
           view
        ;;
        4 )
           log
        ;;
	5 )
           restart
        ;;
        6 )
           uninstall
        ;;
        
        * )
          clear && echo -e "   XrayR MOD BY ADMIN SPEED4G.ME"
        ;;
    esac
}
start_menu "first"
