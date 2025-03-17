# 使用官方 Node.js 镜像作为基础镜像
FROM alpine

# 替换为国内镜像源
RUN echo "https://mirrors.aliyun.com/alpine/v3.16/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/community" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/testing/" >> /etc/apk/repositories

# 安装 Chromium 和依赖
RUN apk -U --no-cache update && \
    apk -U --no-cache --allow-untrusted add \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    fontconfig \
    font-noto-cjk

# 刷新字体缓存
RUN mkfontscale && mkfontdir && fc-cache

# 设置环境变量，指定 Chromium 路径
ENV CHROME_PATH=/usr/bin/chromium-browser
# 设置时区为上海
ENV TZ=Asia/Shanghai
# 设置语言为中文
ENV LANG=zh_CN.UTF-8

