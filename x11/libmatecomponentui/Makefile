# New ports collection makefile for:	libmatecomponentui
# Date created:							14 May 2012
# Whom:									jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	libmatecomponentui
PORTVERSION=	1.2.0
CATEGORIES=	x11 mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Libraries for MATE, a GNU desktop environment

RUN_DEPENDS= 	popt:${PORTSDIR}/devel/popt
LIB_DEPENDS= 	popt:${PORTSDIR}/devel/popt

.if !defined(REFERENCE_PORT)

USE_GETTEXT=	yes
USE_GMAKE=	yes
USE_BISON=	build
USE_XORG=	xpm
USE_LDCONFIG=	yes
USE_AUTOTOOLS=	libtool
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

SUB_FILES=	pkg-deinstall

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>

.endif
