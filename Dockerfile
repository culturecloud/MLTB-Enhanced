FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

COPY libraries.txt .
RUN PIP_BREAK_SYSTEM_PACKAGES=1 pip install --no-cache-dir uv \
    && PIP_BREAK_SYSTEM_PACKAGES=1 uv pip install --no-cache-dir --system -r libraries.txt

COPY . .

RUN chmod -R 777 /usr/src/app

CMD ["bash", "start.sh"]