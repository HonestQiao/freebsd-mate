# New ports collection makefile for:   	matekeyring
# Date Created:							13 May 2012	
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-keyring
PORTVERSION=	1.3.0
CATEGORIES=	security mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	A program that keeps passwords and other secrets

LIB_DEPENDS=	mate-keyring.0:${PORTSDIR}/security/libmate-keyring
RUN_DEPENDS=	${LOCALBASE}/share/certs/ca-root-nss.crt:${PORTSDIR}/security/ca_root_nss

#USE_MATE=	matehack mateprefix gtk20 ltverhack intlhack
USE_GMAKE=	yes
USE_GETTEXT=	yes
USE_AUTOTOOLS=	libtool
USE_LDCONFIG=	yes
CONFIGURE_ARGS=	--with-pam-dir="${PREFIX}/lib" \
		--with-root-certs="${LOCALBASE}/share/certs/ca-root-nss.crt"
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
GLIB_SCHEMAS=	org.mate.crypto.cache.gschema.xml \
		org.mate.crypto.pgp.gschema.xml

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>
