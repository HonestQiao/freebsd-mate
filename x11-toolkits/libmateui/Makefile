# New ports collection makefile for:	libmateui
# Date created:							13 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	libmateui
PORTVERSION=	1.2.0
CATEGORIES=	x11-toolkits mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Libraries for the MATE GUI, a GNU desktop environment

.if !defined(REFERENCE_PORT)

LIB_DEPENDS+=	mate-keyring.0:${PORTSDIR}/security/mate-keyring \
		startup-notification-1.0:${PORTSDIR}/x11/startup-notification
RUN_DEPENDS=	${LOCALBASE}/share/icons/mate/index.theme:${PORTSDIR}/misc/mate-icon-theme

USE_GETTEXT=	yes
USE_XORG=	sm
USE_GMAKE=	yes
USE_MATE=	mateprefix matehack matehier libbonoboui ltverhack \
		referencehack gvfs
USE_LDCONFIG=	yes
USE_AUTOTOOLS=	libtool
USE_BISON=	build
CONFIGURE_ENV=	LIBS="-L${LOCALBASE}/lib ${PTHREAD_LIBS}"
CPPFLAGS+=	-I${LOCALBASE}/include

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>

.endif
