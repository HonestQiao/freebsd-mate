# New ports collection makefile for:	matecommon
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-common
PORTVERSION=	1.2.2
CATEGORIES=	devel
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.2/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Common automake macros for MATE

USE_GMAKE=	yes
GNU_CONFIGURE=	yes
USE_AUTOTOOLS= 	autoconf automake libtool

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>
