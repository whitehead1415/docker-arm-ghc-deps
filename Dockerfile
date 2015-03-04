FROM android/ghc
MAINTAINER whitehead1415@gmail.com


USER root
RUN apt-get -y install freeglut3-dev

USER androidbuilder

ENV PATH /home/androidbuilder/.cabal/bin:/home/androidbuilder/.ghc/android-14/arm-linux-androideabi-4.8/bin:$PATH

RUN mkdir ~/packages ; arm-linux-androideabi-cabal update

WORKDIR /home/androidbuilder/packages

#Get All Packages
RUN cabal get random Yampa OpenGLRaw text transformers hashable primitive unordered-containers nats-1

#Configure Local packages
RUN cd random* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x --user --prefix=$HOME && ./setup build && ./setup install
RUN cd Yampa* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x --user --prefix=$HOME && ./setup build && ./setup install
RUN cd OpenGLRaw* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x --user --prefix=$HOME && ./setup build && ./setup install

#Configure Gloabal Libs

RUN cd text* && ghc ./Setup.lhs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd text* && ./setup build && ./setup install
USER androidbuilder

RUN cd transformers* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd transformers* && ./setup build && ./setup install
USER androidbuilder

RUN cd hashable* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd hashable* && ./setup build && ./setup install
USER androidbuilder

RUN cd primitive* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd primitive* && ./setup build && ./setup install
USER androidbuilder

RUN cd unordered-containers* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd unordered-containers* && ./setup build && ./setup install
USER androidbuilder

RUN cd nats-1* && ghc ./Setup.lhs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
USER root
RUN cd nats-1* && ./setup build && ./setup install

#Install Global Libs
#RUN cd text* && ./setup build && ./setup install ; cd transformers* && ./setup build && ./setup install ; cd hashable* && ./setup build && ./setup install ; cd primitive* && ./setup build && ./setup install ; cd nats-1* && ./setup build && ./setup install ; cd unordered-containers* && ./setup build && ./setup install

RUN rm -rf random* ; rm -rf Yampa* ; rm -rf OpenGLRaw* ; rm -rf text* ; rm -rf transformers* ; rm -rf hashable* ; rm -rf primitive* ; rm -rf unordered-containers* ; rm -rf nats-1*

USER androidbuilder






#RUN cabal get Yampa
#RUN cd Yampa* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x --user --prefix=$HOME
#RUN cd Yampa* && ./setup build && ./setup install
#RUN rm -rf Yampa*
#
#RUN cabal get OpenGLRaw
#RUN cd OpenGLRaw* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x --user --prefix=$HOME
#RUN cd OpenGLRaw* && ./setup build && ./setup install
#RUN rm -rf OpenGLRaw*
#
#RUN cabal get text
#RUN cd text* && ghc ./Setup.lhs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd text* && ./setup build && ./setup install
#RUN rm -rf text*
#
#USER androidbuilder
#
#RUN cabal get transformers
#RUN cd transformers* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd transformers* && ./setup build && ./setup install
#RUN rm -rf transformers*
#
#USER androidbuilder
#
#RUN cabal get hashable
#RUN cd hashable* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd hashable* && ./setup build && ./setup install
#RUN rm -rf hashable*
#
#USER androidbuilder
#
#RUN cabal get primitive
#RUN cd primitive* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd primitive* && ./setup build && ./setup install
#RUN rm -rf primitive*
#
#USER androidbuilder
#
#RUN cabal get unordered-containers
#RUN cd unordered-containers* && ghc ./Setup.hs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd unordered-containers* && ./setup build && ./setup install
#RUN rm -rf unordered-containers*
#
#USER androidbuilder
#
#RUN cabal get nats-1
#RUN cd nats-1* && ghc ./Setup.lhs -o setup && ./setup configure --with-ghc=arm-unknown-linux-androideabi-ghc --with-ghc-pkg=arm-unknown-linux-androideabi-ghc-pkg --with-ld=arm-linux-androideabi-ld --hsc2hs-options=-x
#USER root
#RUN cd nats-1* && ./setup build && ./setup install
#RUN rm -rf nats-1*
#
#USER androidbuilder
#
