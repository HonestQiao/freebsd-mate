# New ports collection makefile for:	matedesktop
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-desktop
PORTVERSION=	1.2.0
CATEGORIES=	x11
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Additional UI API for MATE

.if !defined(REFERENCE_PORT)

LIB_DEPENDS=	startup-notification-1.0:${PORTSDIR}/x11/startup-notification

USE_XORG=	xpm
USE_MATE=	mateprefix matehack intlhack matedocutils gconf2 pygtk2 \
		ltverhack referencehack 
USE_GETTEXT=	yes
USE_GMAKE=	yes
USE_BISON=	build
USE_PYTHON=	yes
INSTALLS_OMF=	yes
USE_LDCONFIG=	yes
USE_AUTOTOOLS=	libtool
CONFIGURE_ARGS=	--with-mate-distributor="FreeBSD MATE Project"
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

MAN1=	mate-about.1

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>

.endif
