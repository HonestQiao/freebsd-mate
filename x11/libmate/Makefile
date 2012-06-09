# New ports collection makefile for:	libmate
# Date created:							13 May 2012
# Whom:									jin-Sih Lin <linpct@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	libmate
PORTVERSION=	1.3.0
CATEGORIES=	x11 mate
MASTER_SITES=	http://pub.mate-desktop.org/releases/1.3/
DISTFILES= 	${DISTNAME}.tar.xz

MAINTAINER=	linpct@gmail.com
COMMENT=	Libraries for MATE, a GNU desktop environment

.if !defined(REFERENCE_PORT)

BUILD_DEPENDS=	rarian-sk-config:${PORTSDIR}/textproc/rarian
LIB_DEPENDS=	canberra-gtk.0:${PORTSDIR}/audio/libcanberra
RUN_DEPENDS=	rarian-sk-config:${PORTSDIR}/textproc/rarian

USE_GETTEXT=	yes
USE_GMAKE=	yes
USE_MATE=	mateprefix matehack intlhack esound libbonobo \
		matevfs2 ltverhack referencehack
USE_BISON=	build
USE_XORG=	xpm
USE_LDCONFIG=	yes
USE_AUTOTOOLS=	libtool
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib

SUB_FILES=	pkg-deinstall

MAN7=		mate-options.7

GCONF_SCHEMAS=	desktop_mate_accessibility_keyboard.schemas \
		desktop_mate_accessibility_startup.schemas \
		desktop_mate_applications_at_mobility.schemas \
		desktop_mate_applications_at_visual.schemas \
		desktop_mate_applications_browser.schemas \
		desktop_mate_applications_office.schemas \
		desktop_mate_applications_terminal.schemas \
		desktop_mate_applications_window_manager.schemas \
		desktop_mate_background.schemas \
		desktop_mate_file_views.schemas \
		desktop_mate_interface.schemas \
		desktop_mate_lockdown.schemas \
		desktop_mate_peripherals_keyboard.schemas \
		desktop_mate_peripherals_mouse.schemas \
		desktop_mate_sound.schemas \
		desktop_mate_thumbnail_cache.schemas \
		desktop_mate_thumbnailers.schemas \
		desktop_mate_typing_break.schemas

pre-configure:
	cd ${WRKSRC} && ./autogen.sh

post-patch:
	@${REINPLACE_CMD} -e 's|%%LOCALBASE%%|${LOCALBASE}|' \
		${WRKSRC}/libmate/libmate-2.0.pc.in
	@${REINPLACE_CMD} -e '/^$$/d' ${WRKSRC}/po/POTFILES.in

.include <bsd.port.mk>

.endif
