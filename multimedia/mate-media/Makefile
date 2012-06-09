# New ports collection makefile for:	matemedia
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-media
PORTVERSION=	1.3.0
CATEGORIES=	x11
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Additional UI API for MATE

.if !defined(REFERENCE_PORT)

USE_GMAKE=	yes

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>

.endif
