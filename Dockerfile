FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY libraries.txt .
RUN pip3 install --no-cache-dir -r libraries.txt

COPY . .

CMD ["bash", "start.sh"]