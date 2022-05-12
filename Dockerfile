FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wget   -y
RUN wget -O /root/tinyweb https://github.com/HyNetwork/hysteria/releases/download/v1.0.4/hysteria-linux-amd64
RUN chmod 755 /root/tinyweb
RUN openssl ecparam -genkey -name prime256v1 -out /root/ca.key
RUN openssl req -new -x509 -days 36500 -key /root/ca.key -out /root/ca.crt  -subj "/CN=bing.com"
RUN echo '{' > /root/config.json
RUN echo '  "listen": ":8080",' >>/root/config.json
RUN echo '  "cert": "/root/hy/ca.crt",' >>/root/config.json
RUN echo '  "key": "/root/hy/ca.key",' >>/root/config.json
RUN echo '  "obfs": "tinyweb"' >>/root/config.json
RUN echo '}' >>/root/config.json

EXPOSE 8080/udp
CMD /root/tinyweb
