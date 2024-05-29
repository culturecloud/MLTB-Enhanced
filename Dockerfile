FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

COPY libraries.txt .
RUN pip install --no-cache-dir --break-system-packages uv \
    && uv pip install --no-cache-dir --system --break-system-packages -r libraries.txt

COPY . .

RUN chmod -R 777 /usr/src/app

CMD ["bash", "start.sh"]