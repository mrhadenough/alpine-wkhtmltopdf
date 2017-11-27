FROM gliderlabs/alpine:3.6
RUN apk add qt5-qtbase-dev \
    wkhtmltopdf \
    --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted

RUN apk add --no-cache \
    xvfb \
    # Additionnal dependencies for better rendering
    ttf-freefont \
    fontconfig \
    dbus

RUN mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1600x900x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

ENTRYPOINT ["wkhtmltopdf"]

CMD ["-h"]
