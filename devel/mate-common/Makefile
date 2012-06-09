# New ports collection makefile for:	matecommon
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-common
PORTVERSION=	1.3.0
CATEGORIES=	devel
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Common automake macros for MATE

USE_GMAKE=	yes
GNU_CONFIGURE=	yes
USE_AUTOTOOLS= 	autoconf automake libtool

MAN1=	mate-autogen.1 mate-doc-common.1

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>
