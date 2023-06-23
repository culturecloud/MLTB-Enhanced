FROM culturecloud/mltb:wzml

WORKDIR /home/culturecloud/mltb

COPY --chown=culturecloud:culturecloud libraries.txt .

RUN python3 -m pip install \
    -qU pip setuptools wheel \
    && python3 -m pip install \
    --no-cache-dir -qUr libraries.txt \
    && cd ../megasdk/bindings/python \
    && python3 setup.py bdist_wheel \
    && python3 -m pip install dist/*.whl

COPY --chown=culturecloud:culturecloud . .

USER culturecloud
WORKDIR /home/culturecloud/mltb

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bash", "start.sh"]
