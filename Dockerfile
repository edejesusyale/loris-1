#based on https://github.com/loris-imageserver/loris-docker
FROM ubuntu

ENV HOME /root

# Update packages and install tools 
RUN apt-get update -y && apt-get install -y wget git unzip
RUN apt-get -y install python3.6 python3-distutils
# Install pip and python libs
RUN wget https://bootstrap.pypa.io/get-pip.py \
    && python3.6 get-pip.py
RUN apt-get install -y python-dev python-setuptools python-pip
RUN python3.6 -m pip install --upgrade pip
RUN python3.6 -m pip install Werkzeug
RUN python3.6 -m pip install configobj
RUN python3.6 -m pip install orm
RUN python3.6 -m pip install configobj
RUN python3.6 -m pip install requests
RUN python3.6 -m pip install mock
RUN python3.6 -m pip install encode
RUN python3.6 -m pip install PyJWT
RUN python3.6 -m pip install responses
RUN python3.6 -m pip install attrs
RUN python3.6 -m pip install cryptography
RUN python3.6 -m pip install boto3
# Install loris
RUN wget --no-check-certificate https://github.com/edejesusyale/loris-1/archive/ptiff_docker.zip \
    && unzip ptiff_docker \
    && mv loris-1-ptiff_docker /opt/loris \
    && rm ptiff_docker.zip

# Install kakadu
RUN wget --no-check-certificate https://kakadusoftware.com/wp-content/uploads/2020/02/KDU803_Demo_Apps_for_Linux-x86-64_200210.zip \
    && unzip KDU803_Demo_Apps_for_Linux-x86-64_200210 \
    && mv  KDU803_Demo_Apps_for_Linux-x86-64_200210 temp_folder/ \
    && chmod 755 temp_folder/libkdu_v80R.so \
    && chmod 755 temp_folder/kdu_expand \
    && mv temp_folder/libkdu_v80R.so /usr/local/lib/libkdu_v80R.so \
    && mv temp_folder/kdu_expand /usr/local/lib/kdu_expand \
    && rm KDU803_Demo_Apps_for_Linux-x86-64_200210.zip && rm  -r temp_folder

RUN ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/ \
	&& ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/ \
	&& ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/ \
	&& ln -s /usr/lib/`uname -i`-linux-gnu/liblcms.so /usr/lib/ \
	&& ln -s /usr/lib/`uname -i`-linux-gnu/libtiff.so /usr/lib/ \

RUN echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig

# Install Pillow
RUN apt-get install -y  libjpeg-turbo8-dev libfreetype6-dev zlib1g-dev \
                        liblcms2-dev liblcms2-utils libtiff5-dev python-dev libwebp-dev apache2 \
                        libapache2-mod-wsgi

WORKDIR /opt

# Get loris and unzip.
#COPY . loris/

RUN useradd -d /var/www/loris -s /sbin/false loris

WORKDIR /opt/loris

RUN python3.6 -m pip install Pillow

RUN python ./setup.py install

WORKDIR /opt/loris/

# bind test server to 0.0.0.0
RUN sed -i -- 's/localhost/0.0.0.0/g' loris/webapp.py

EXPOSE 5004
CMD ["bash" , "startserver.sh"]