FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

COPY requirements.txt .
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip install --no-cache-dir uv \
    && PIP_BREAK_SYSTEM_PACKAGES=1 uv pip install --no-cache-dir --system -r requirements.txt

COPY . .

RUN chmod -R 777 /usr/src/app

CMD ["bash", "start.sh"]
