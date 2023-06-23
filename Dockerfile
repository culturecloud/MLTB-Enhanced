FROM culturecloud/mltb:anasty17

USER culturecloud
WORKDIR /home/culturecloud/mltb

COPY . .

CMD ["bash", "start.sh"]
