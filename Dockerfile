FROM centos/python-36-centos7

USER 0
RUN yum install -y openjpeg2-tools && ln -s /usr/bin/opj2_decompress /usr/bin/opj_decompress

USER 1001
COPY ./requirements*txt ./
RUN pip3 install pytest && pip3 install --requirement requirements.txt && pip3 install --requirement requirements_test.txt && pip3 install pdbpp
CMD ["bash"]
