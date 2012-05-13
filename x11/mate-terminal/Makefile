# New ports collection makefile for:	mateterminal
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-terminal
PORTVERSION=	1.2.1
CATEGORIES=	x11 mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER= 	linpct@gmail.com
COMMENT=	Terminal component for the MATE Desktop

LIB_DEPENDS=	startup-notification-1.0:${PORTSDIR}/x11/startup-notification

USE_GETTEXT=	yes
INSTALLS_OMF=	yes
USE_GMAKE=	yes
USE_XORG=	sm
USE_MATE=	mateprefix matehack intlhack gconf2 vte matedocutils \
		libmate
GNU_CONFIGURE=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

GCONF_SCHEMAS=	mate-terminal.schemas

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>
