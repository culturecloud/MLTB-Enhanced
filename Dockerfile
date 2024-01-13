FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app

COPY libraries.txt .
RUN pip3 install --no-cache-dir -r libraries.txt

COPY . .

RUN chmod -R 777 /usr/src/app

CMD ["bash", "start.sh"]