FROM mono:6 AS webminerpool-build


COPY server /server
COPY hash_cn /hash_cn

RUN apt-get -qq update && \
	apt-get --no-install-recommends -qq install build-essential && \
	rm -rf /var/lib/apt/lists/* && \
	cd /hash_cn/libhash && \
	make && \
	cd /server && \
	msbuild Server.sln /p:Configuration=Release_Server /p:Platform="any CPU"

FROM mono:6

RUN mkdir /webminerpool

# Install acme.sh
RUN apt-get -qq update && \
	apt-get install --no-install-recommends -qq \
		coreutils \
		cron \
		curl \
		git \
		openssl \
		socat && \
	rm -rf /var/lib/apt/lists/* && \
	git clone https://github.com/Neilpang/acme.sh.git /root/acme.sh && \
	cd /root/acme.sh && \
	git checkout 2.8.5 && \
	/root/acme.sh/acme.sh --install --home /root/.acme.sh
COPY entrypoint.sh /entrypoint.sh
COPY --from=webminerpool-build /server/Server/bin/Release_Server/server.exe /webminerpool
COPY --from=webminerpool-build /server/Server/bin/Release_Server/pools.json /webminerpool
COPY --from=webminerpool-build /hash_cn/libhash/libhash.so /webminerpool
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
