# New ports collection makefile for:	matedocutils
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-doc-utils
PORTVERSION=	1.2.1
CATEGORIES=	textproc
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	MATE doc utils

BUILD_DEPENDS=	rarian-sk-config:${PORTSDIR}/textproc/rarian \
		${PYTHON_SITELIBDIR}/libxml2mod.so:${PORTSDIR}/textproc/py-libxml2 \
    		gawk:${PORTSDIR}/lang/gawk

RUN_DEPENDS=	rarian-sk-config:${PORTSDIR}/textproc/rarian \
		${PYTHON_SITELIBDIR}/libxml2mod.so:${PORTSDIR}/textproc/py-libxml2 \
		${LOCALBASE}/share/xml/docbook/4.3/catalog.xml:${PORTSDIR}/textproc/docbook-xml-430 \
		${LOCALBASE}/share/xml/docbook/4.4/catalog.xml:${PORTSDIR}/textproc/docbook-xml-440 \

USE_MATE= 	intltool matehier matehack libxslt intlhack
USE_GMAKE=	yes
MAKE_JOBS_UNSAFE=yes
USE_GETTEXT=	yes
USE_PYTHON=	yes
INSTALLS_OMF=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--with-omf-dir=${PREFIX}/share/omf
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

MAN1=		xml2po.1

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

post-install:
	@${PYTHON_CMD} ${PYTHON_LIBDIR}/compileall.py -l ${PYTHON_SITELIBDIR}/xml2po
	@${PYTHON_CMD} ${PYTHON_LIBDIR}/compileall.py -l ${PYTHON_SITELIBDIR}/xml2po/modes
	mv ${LOCALBASE}/share/pkgconfig/mate-doc-utils.pc ${LOCALBASE}/lib/pkgconfig/mate-doc-utils.pc
	mv ${LOCALBASE}/share/pkgconfig/xml2po.pc ${LOCALBASE}/lib/pkgconfig/xml2po.pc

.include <bsd.port.mk>
