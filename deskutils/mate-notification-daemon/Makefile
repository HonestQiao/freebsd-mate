# New ports collection makefile for:	mate-notification-daemon
# Date created:							12 May 2012
# Whom:									Jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	mate-notification-daemon
PORTVERSION=	1.3.1
CATEGORIES=	x11
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES=	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Notification Daemon for MATE

.if !defined(REFERENCE_PORT)

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

.include <bsd.port.mk>

.endif
