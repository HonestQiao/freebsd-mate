# New ports collection makefile for:	mate-file-manager-sendto
# Date created:							13 May 2012
# Whom:									jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-file-manager-sendto
PORTVERSION=	1.3.0
CATEGORIES=	x11 mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Libraries for MATE, a GNU desktop environment

USE_GMAKE=	yes
pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>
