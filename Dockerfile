FROM anasty17/mltb

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN playwright install chromium
RUN playwright install-deps

RUN apt-get update --fix-missing \
    && apt-get install -y mediainfo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r modules.txt

COPY . .

CMD ["bash", "start.sh"]
