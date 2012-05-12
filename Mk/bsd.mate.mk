#-*- mode: Fundamental; tab-width: 4; -*-
# ex:ts=4
#
# $FreeBSD: ports/Mk/bsd.mate.mk,v 1.173 2011/08/12 08:03:18 kwm Exp $
#	$NetBSD: $
#     $MCom: ports/Mk/bsd.mate.mk,v 1.549 2011/06/10 22:16:59 mezz Exp $
#
# Please view me with 4 column tabs!

#######################################################
#
# *** WARNING: Disable MARCUSCOM before merge in FreeBSD!
#     Please also remove this section before merging into FreeBSD.
#
#MARCUSCOM_CVS=yes

# ======================= USERS =================================
#
# There are no significant user-definable settings in here.
# This file is a framework to make it easier to create MATE ports.
#
# ======================= /USERS ================================

.if !defined(_POSTMKINCLUDED) && !defined(Gnome_Pre_Include)

# Please make sure all changes to this file are passed through the maintainer.
# Do not commit them yourself (unless of course you're the Port's Wraith ;).
Gnome_Include_MAINTAINER=	mate@FreeBSD.org
Gnome_Pre_Include=			bsd.mate.mk

# This section defines possible names of MATE components and all information
# necessary for ports to use those components.

# Ports can use this as follows:
#
# USE_MATE=	mateprint bonobo
#
# .include <bsd.port.mk>
#
# As a result proper LIB_DEPENDS/RUN_DEPENDS will be added and CONFIGURE_ENV
# and MAKE_ENV defined.
#
#
# GCONF_SCHEMAS		- Set the following to list of all the gconf schema files
#				that your port installs. These schema files and
#				%gconf.xml files will be automatically added to
#				the ${PLIST}. For example, if your port has
#				"etc/gconf/schemas/(foo.schemas and bar.schemas)",
#				add the following to your Makefile:
#				"GCONF_SCHEMAS=foo.schemas bar.schemas".
#
# GLIB_SCHEMAS		- Set the following to list of all gsettings schema files
#				(*.gschema.xml) that your ports installs. The 
#				schema files will be automatically added to 
#				the ${PLIST}. For example, if your port has 
#				"share/glib-2.0/schemas/(foo.gschema.xml and bar.gschema.xml)", 
#				add the following to your Makefile:
#				"GLIB_SCHEMAS=foo.gschema.xml bar.gschema.xml".
#
# INSTALLS_OMF		- If set, bsd.mate.mk will automatically scan pkg-plist
#				file and add apropriate @exec/@unexec directives for
#				each .omf file found to track OMF registration database.
#
# INSTALLS_ICONS	- If your port installs Freedesktop-style icons to
#				${LOCALBASE}/share/icons, then you should use this
#				macro. If the icons are not cached, they will not be
#				displayed.
#

# non-version specific components
_USE_MATE_ALL= esound intlhack intltool ltasneededhack lthack ltverhack \
		matehack referencehack matehier matemimedata mateprefix \
		pkgconfig

# MATE 1 components
_USE_MATE_ALL+= bonobo gal gconf gdkpixbuf glib12 \
		matecanvas matedb matelibs mateprint matevfs gtk12 \
		libgda libghttp libglade libxml imlib oaf orbit pygtk

# MATE 2 components
_USE_MATE_ALL+= atk atspi desktopfileutils eel2 evolutiondataserver gal2 \
		gdkpixbuf2 gconf2 _glib20 glib20 matecontrolcenter2 matedesktop \
		matedesktopsharp20 matedocutils matemenus matepanel matesharp20 \
		matespeech matevfs2 gtk-update-icon-cache gtk20 gtkhtml3 gtksharp10 \
		gtksharp20 gtksourceview gtksourceview2 gvfs libartlgpl2 libbonobo \
		libbonoboui libgailmate libgda2 libgda3 libgda4 libglade2 libmate \
		libmatecanvas libmatedb libmatekbd libmateprint libmateprintui \
		libmateui libgsf libgsf_mate libgtkhtml libidl librsvg2 libwnck \
		libxml2 libxslt libzvt linc metacity nautilus2 nautiluscdburner \
		orbit2 pango pymate2 pymatedesktop pymateextras pygobject pygtk2 \
		pygtksourceview vte

# MATE 3 components
_USE_MATE_ALL+= dconf gtk30

MATE_MAKEFILEIN?=	Makefile.in
SCROLLKEEPER_DIR=	/var/db/rarian
matehack_PRE_PATCH=	${FIND} ${WRKSRC} -name "${MATE_MAKEFILEIN}*" -type f | ${XARGS} ${REINPLACE_CMD} -e \
				's|[(]libdir[)]/locale|(prefix)/share/locale|g ; \
				 s|[(]libdir[)]/pkgconfig|(prefix)/libdata/pkgconfig|g ; \
				 s|[(]datadir[)]/pkgconfig|(prefix)/libdata/pkgconfig|g ; \
				 s|[(]prefix[)]/lib/pkgconfig|(prefix)/libdata/pkgconfig|g ; \
				 s|[$$][(]localstatedir[)]/scrollkeeper|${SCROLLKEEPER_DIR}|g ; \
				 s|[(]libdir[)]/bonobo/servers|(prefix)/libdata/bonobo/servers|g' ; \
			${FIND} ${WRKSRC} -name "configure" -type f | ${XARGS} ${REINPLACE_CMD} -e \
				's|-lpthread|${PTHREAD_LIBS}|g ; \
				 s|DATADIRNAME=lib|DATADIRNAME=share|g ; \
				 s|{libdir}/locale|{prefix}/share/locale|g'

referencehack_PRE_PATCH=	${FIND} ${WRKSRC} -name "Makefile.in" -type f | ${XARGS} ${REINPLACE_CMD} -e \
				"s|test \"\$$\$$installfiles\" = '\$$(srcdir)/html/\*'|:|"

lthack_PRE_PATCH=	${FIND} ${WRKSRC} -name "configure" -type f | ${XARGS} ${REINPLACE_CMD} -e \
				'/^LIBTOOL_DEPS="$$ac_aux_dir\/ltmain.sh"$$/s|$$|; $$ac_aux_dir/ltconfig $$LIBTOOL_DEPS;|'

MATE_MTREE_FILE?=		${LOCALBASE}/etc/mtree/BSD.mate.dist
matehier_DETECT=	${MATE_MTREE_FILE}
matehier_RUN_DEPENDS=	${matehier_DETECT}:${PORTSDIR}/misc/matehier

MATE_HTML_DIR?=	${PREFIX}/share/doc
GCONF_CONFIG_OPTIONS?=	merged
GCONF_CONFIG_DIRECTORY?=etc/gconf/gconf.xml.defaults
GCONF_CONFIG_SOURCE?=xml:${GCONF_CONFIG_OPTIONS}:${PREFIX}/${GCONF_CONFIG_DIRECTORY}
MATE_LOCALSTATEDIR?=	${PREFIX}/share
mateprefix_CONFIGURE_ENV=GTKDOC="false"
mateprefix_CONFIGURE_ARGS=--localstatedir=${MATE_LOCALSTATEDIR} \
			   --with-html-dir=${MATE_HTML_DIR} \
			   --disable-gtk-doc \
			   --with-gconf-source=${GCONF_CONFIG_SOURCE}
mateprefix_USE_MATE_IMPL=matehier

ESD_CONFIG?=		${LOCALBASE}/bin/esd-config
esound_LIB_DEPENDS=	esd.2:${PORTSDIR}/audio/esound
esound_CONFIGURE_ENV=	ESD_CONFIG="${ESD_CONFIG}"
esound_MAKE_ENV=	ESD_CONFIG="${ESD_CONFIG}"
esound_DETECT=		${ESD_CONFIG}

libghttp_LIB_DEPENDS=	ghttp.1:${PORTSDIR}/www/libghttp
libghttp_DETECT=	${LOCALBASE}/etc/ghttpConf.sh

GLIB_CONFIG?=		${LOCALBASE}/bin/glib12-config
glib12_LIB_DEPENDS=	glib-12.3:${PORTSDIR}/devel/glib12
glib12_CONFIGURE_ENV=	GLIB_CONFIG="${GLIB_CONFIG}"
glib12_MAKE_ENV=	GLIB_CONFIG="${GLIB_CONFIG}"
glib12_DETECT=		${GLIB_CONFIG}
glib12_USE_MATE_IMPL=	pkgconfig

GTK_CONFIG?=		${LOCALBASE}/bin/gtk12-config
gtk12_LIB_DEPENDS=	gtk-12.2:${PORTSDIR}/x11-toolkits/gtk12
gtk12_CONFIGURE_ENV=	GTK_CONFIG="${GTK_CONFIG}"
gtk12_MAKE_ENV=		GTK_CONFIG="${GTK_CONFIG}"
gtk12_DETECT=		${GTK_CONFIG}
gtk12_USE_MATE_IMPL=	glib12

XML_CONFIG?=		${LOCALBASE}/bin/xml-config
libxml_LIB_DEPENDS=	xml.5:${PORTSDIR}/textproc/libxml
libxml_CONFIGURE_ENV=	XML_CONFIG="${XML_CONFIG}"
libxml_MAKE_ENV=	XML_CONFIG="${XML_CONFIG}"
libxml_DETECT=		${XML_CONFIG}
libxml_USE_MATE_IMPL=	glib12

ORBIT_CONFIG?=		${LOCALBASE}/bin/orbit-config
orbit_LIB_DEPENDS=	ORBit.2:${PORTSDIR}/devel/ORBit
orbit_CONFIGURE_ENV=	ORBIT_CONFIG="${ORBIT_CONFIG}"
orbit_MAKE_ENV=		ORBIT_CONFIG="${ORBIT_CONFIG}"
orbit_DETECT=		${ORBIT_CONFIG}
orbit_USE_MATE_IMPL=	glib12

GDK_PIXBUF_CONFIG?=	${LOCALBASE}/bin/gdk-pixbuf-config
gdkpixbuf_LIB_DEPENDS=	gdk_pixbuf.2:${PORTSDIR}/graphics/gdk-pixbuf
gdkpixbuf_CONFIGURE_ENV=GDK_PIXBUF_CONFIG="${GDK_PIXBUF_CONFIG}"
gdkpixbuf_MAKE_ENV=	GDK_PIXBUF_CONFIG="${GDK_PIXBUF_CONFIG}"
gdkpixbuf_DETECT=	${GDK_PIXBUF_CONFIG}
gdkpixbuf_USE_MATE_IMPL=gtk12

IMLIB_CONFIG?=		${LOCALBASE}/bin/imlib-config
imlib_LIB_DEPENDS=	Imlib.5:${PORTSDIR}/graphics/imlib
imlib_CONFIGURE_ENV=	IMLIB_CONFIG="${IMLIB_CONFIG}"
imlib_MAKE_ENV=		IMLIB_CONFIG="${IMLIB_CONFIG}"
imlib_DETECT=		${IMLIB_CONFIG}
imlib_USE_MATE_IMPL=	gtk12

MATE_CONFIG?=		${LOCALBASE}/bin/mate-config
matelibs_LIB_DEPENDS=	mate.5:${PORTSDIR}/x11/mate-libs
matelibs_CONFIGURE_ENV=MATE_CONFIG="${MATE_CONFIG}"
matelibs_MAKE_ENV=	MATE_CONFIG="${MATE_CONFIG}"
matelibs_DETECT=	${MATE_CONFIG}
matelibs_USE_MATE_IMPL=esound gtk12 imlib libxml orbit

matecanvas_LIB_DEPENDS=matecanvaspixbuf.1:${PORTSDIR}/graphics/matecanvas
matecanvas_DETECT=	${LOCALBASE}/etc/matecanvaspixbufConf.sh
matecanvas_USE_MATE_IMPL=matelibs gdkpixbuf

OAF_CONFIG?=		${LOCALBASE}/bin/oaf-config
oaf_LIB_DEPENDS=	oaf.0:${PORTSDIR}/devel/oaf
oaf_CONFIGURE_ENV=	OAF_CONFIG="${OAF_CONFIG}"
oaf_MAKE_ENV=		OAF_CONFIG="${OAF_CONFIG}"
oaf_DETECT=		${OAF_CONFIG}
oaf_USE_MATE_IMPL=	glib12 orbit libxml

matemimedata_DETECT=	${LOCALBASE}/libdata/pkgconfig/mate-mime-data-2.0.pc
matemimedata_BUILD_DEPENDS=${matemimedata_DETECT}:${PORTSDIR}/misc/mate-mime-data
matemimedata_RUN_DEPENDS=${matemimedata_DETECT}:${PORTSDIR}/misc/mate-mime-data
matemimedata_USE_MATE_IMPL=matehier pkgconfig

GCONF_CONFIG?=		${LOCALBASE}/bin/gconf-config
gconf_LIB_DEPENDS=	gconf-1.1:${PORTSDIR}/devel/gconf
gconf_CONFIGURE_ENV=	GCONF_CONFIG="${GCONF_CONFIG}"
gconf_MAKE_ENV=		GCONF_CONFIG="${GCONF_CONFIG}"
gconf_DETECT=		${GCONF_CONFIG}
gconf_USE_MATE_IMPL=	oaf

MATE_VFS_CONFIG?=	${LOCALBASE}/bin/mate-vfs-config
matevfs_LIB_DEPENDS=	matevfs.0:${PORTSDIR}/devel/mate-vfs1
matevfs_CONFIGURE_ENV=	MATE_VFS_CONFIG="${MATE_VFS_CONFIG}"
matevfs_MAKE_ENV=	MATE_VFS_CONFIG="${MATE_VFS_CONFIG}"
matevfs_DETECT=	${MATE_VFS_CONFIG}
matevfs_USE_MATE_IMPL=matemimedata gconf matelibs

mateprint_LIB_DEPENDS=	mateprint.16:${PORTSDIR}/print/mate-print
mateprint_DETECT=	${LOCALBASE}/etc/printConf.sh
mateprint_USE_MATE_IMPL=matelibs matecanvas

bonobo_LIB_DEPENDS=	bonobo.2:${PORTSDIR}/devel/bonobo
bonobo_DETECT=		${LOCALBASE}/etc/bonoboConf.sh
bonobo_USE_MATE_IMPL=	oaf mateprint

GDA_CONFIG?=		${LOCALBASE}/bin/gda-config
libgda_LIB_DEPENDS=	gda-client.0:${PORTSDIR}/databases/libgda
libgda_CONFIGURE_ENV=	GDA_CONFIG="${GDA_CONFIG}"
libgda_MAKE_ENV=	GDA_CONFIG="${GDA_CONFIG}"
libgda_DETECT=		${GDA_CONFIG}
libgda_USE_MATE_IMPL=	gconf bonobo

MATEDB_CONFIG?=	${LOCALBASE}/bin/matedb-config
matedb_LIB_DEPENDS=	matedb.0:${PORTSDIR}/databases/mate-db
matedb_CONFIGURE_ENV=	MATEDB_CONFIG="${MATEDB_CONFIG}"
matedb_MAKE_ENV=	MATEDB_CONFIG="${MATEDB_CONFIG}"
matedb_DETECT=		${MATEDB_CONFIG}
matedb_USE_MATE_IMPL=	libgda

LIBGLADE_CONFIG?=	${LOCALBASE}/bin/libglade-config
libglade_LIB_DEPENDS=	glade.4:${PORTSDIR}/devel/libglade
libglade_CONFIGURE_ENV=	LIBGLADE_CONFIG="${LIBGLADE_CONFIG}"
libglade_MAKE_ENV=	LIBGLADE_CONFIG="${LIBGLADE_CONFIG}"
libglade_DETECT=	${LIBGLADE_CONFIG}
libglade_USE_MATE_IMPL=matedb

gal_LIB_DEPENDS=	gal.23:${PORTSDIR}/x11-toolkits/gal
gal_DETECT=		${LOCALBASE}/etc/galConf.sh
gal_USE_MATE_IMPL=	libglade

pygtk_DETECT=			${LOCALBASE}/bin/pygtk-codegen-1.2
pygtk_BUILD_DEPENDS=	${pygtk_DETECT}:${PORTSDIR}/x11-toolkits/py-gtk
pygtk_RUN_DEPENDS=		${pygtk_DETECT}:${PORTSDIR}/x11-toolkits/py-gtk
pygtk_USE_MATE_IMPL=	matelibs gdkpixbuf libglade

_glib20_LIB_DEPENDS=	glib-2.0.0:${PORTSDIR}/devel/glib20
_glib20_DETECT=		${LOCALBASE}/libdata/pkgconfig/glib-2.0.pc
_glib20_USE_MATE_IMPL=	pkgconfig

glib20_RUN_DEPENDS=	${LOCALBASE}/lib/gio/modules/libgiofam.so:${PORTSDIR}/devel/gio-fam-backend
glib20_DETECT=		${LOCALBASE}/lib/gio/modules/libgiofam.so
glib20_USE_MATE_IMPL=	_glib20

atk_LIB_DEPENDS=	atk-1.0.0:${PORTSDIR}/accessibility/atk
atk_DETECT=		${LOCALBASE}/libdata/pkgconfig/atk.pc
atk_USE_MATE_IMPL=	glib20

dconf_LIB_DEPENDS=	dconf.0:${PORTSDIR}/devel/dconf
dconf_DETECT=		${LOCALBASE}/libdata/pkgconfig/dconf.pc
dconf_USE_MATE_IMPL=	glib20

pango_LIB_DEPENDS=	pango-1.0.0:${PORTSDIR}/x11-toolkits/pango
pango_DETECT=		${LOCALBASE}/libdata/pkgconfig/pango.pc
pango_USE_MATE_IMPL=	glib20

gdkpixbuf2_LIB_DEPENDS=	gdk_pixbuf-2.0.0:${PORTSDIR}/graphics/gdk-pixbuf2
gdkpixbuf2_DETECT=	${LOCALBASE}/libdata/pkgconfig/gdk-pixbuf-2.0.pc
gdkpixbuf2_USE_MATE_IMPL=glib20

gtk-update-icon-cache_BUILD_DEPENDS=	gtk-update-icon-cache:${PORTSDIR}/graphics/gtk-update-icon-cache
gtk-update-icon-cache_RUN_DEPENDS=	gtk-update-icon-cache:${PORTSDIR}/graphics/gtk-update-icon-cache
gtk-update-icon-cache_DETECT=		${LOCALBASE}/bin/gtk-update-icon-cache
gtk-update-icon-cache_USE_MATE_IMPL=	atk pango gdkpixbuf2

gtk20_LIB_DEPENDS=	gtk-x11-2.0.0:${PORTSDIR}/x11-toolkits/gtk20
gtk20_DETECT=		${LOCALBASE}/libdata/pkgconfig/gtk+-x11-2.0.pc
gtk20_USE_MATE_IMPL=	intltool atk pango
GTK2_VERSION=		2.10.0

gtk30_LIB_DEPENDS=	gtk-3.0:${PORTSDIR}/x11-toolkits/gtk30
gtk30_DETECT=		${LOCALBASE}/libdata/pkgconfig/gtk+-3.0.pc
gtk30_USE_MATE_IMPL=	intltool atk pango
GTK3_VERSION=		3.0.0

linc_LIB_DEPENDS=	linc.1:${PORTSDIR}/net/linc
linc_DETECT=		${LOCALBASE}/libdata/pkgconfig/linc.pc
linc_USE_MATE_IMPL=	glib20

libidl_LIB_DEPENDS=	IDL-2.0:${PORTSDIR}/devel/libIDL
libidl_DETECT=		${LOCALBASE}/libdata/pkgconfig/libIDL-2.0.pc
libidl_USE_MATE_IMPL=	glib20

orbit2_LIB_DEPENDS=	ORBit-2.0:${PORTSDIR}/devel/ORBit2
orbit2_DETECT=		${LOCALBASE}/libdata/pkgconfig/ORBit-2.0.pc
orbit2_USE_MATE_IMPL=	libidl

libglade2_LIB_DEPENDS=	glade-2.0.0:${PORTSDIR}/devel/libglade2
libglade2_DETECT=	${LOCALBASE}/libdata/pkgconfig/libglade-2.0.pc
libglade2_USE_MATE_IMPL=libxml2 gtk20

libxml2_LIB_DEPENDS=	xml2.5:${PORTSDIR}/textproc/libxml2
libxml2_DETECT=		${LOCALBASE}/libdata/pkgconfig/libxml-2.0.pc
libxml2_USE_MATE_IMPL=	pkgconfig

libxslt_LIB_DEPENDS=	xslt.2:${PORTSDIR}/textproc/libxslt
libxslt_DETECT=		${LOCALBASE}/libdata/pkgconfig/libxslt.pc
libxslt_USE_MATE_IMPL=	libxml2

libbonobo_LIB_DEPENDS=	bonobo-2.0:${PORTSDIR}/devel/libbonobo
libbonobo_DETECT=	${LOCALBASE}/libdata/pkgconfig/libbonobo-2.0.pc
libbonobo_USE_MATE_IMPL=libxml2 orbit2

gconf2_LIB_DEPENDS=	gconf-2.4:${PORTSDIR}/devel/gconf2
gconf2_DETECT=		${LOCALBASE}/libdata/pkgconfig/gconf-2.0.pc
gconf2_USE_MATE_IMPL=	orbit2 libxml2 gtk20

matevfs2_LIB_DEPENDS=	matevfs-2.0:${PORTSDIR}/devel/mate-vfs
matevfs2_DETECT=	${LOCALBASE}/libdata/pkgconfig/mate-vfs-2.0.pc
matevfs2_USE_MATE_IMPL=gconf2 matemimedata

libmatecanvas_LIB_DEPENDS=	matecanvas-2.0:${PORTSDIR}/graphics/libmatecanvas
libmatecanvas_DETECT=		${LOCALBASE}/libdata/pkgconfig/libmatecanvas-2.0.pc
libmatecanvas_USE_MATE_IMPL=	libglade2 libartlgpl2

libartlgpl2_LIB_DEPENDS=	art_lgpl_2.5:${PORTSDIR}/graphics/libart_lgpl
libartlgpl2_DETECT=		${LOCALBASE}/libdata/pkgconfig/libart-2.0.pc
libartlgpl2_USE_MATE_IMPL=	pkgconfig

libmateprint_LIB_DEPENDS=	mateprint-2-2.0:${PORTSDIR}/print/libmateprint
libmateprint_DETECT=		${LOCALBASE}/libdata/pkgconfig/libmateprint-2.2.pc
libmateprint_USE_MATE_IMPL=	libbonobo libartlgpl2 gtk20

libmateprintui_LIB_DEPENDS=	mateprintui-2-2.0:${PORTSDIR}/x11-toolkits/libmateprintui
libmateprintui_DETECT=		${LOCALBASE}/libdata/pkgconfig/libmateprintui-2.2.pc
libmateprintui_USE_MATE_IMPL=	libmateprint libmatecanvas

libmate_LIB_DEPENDS=	mate-2.0:${PORTSDIR}/x11/libmate
libmate_DETECT=	${LOCALBASE}/libdata/pkgconfig/libmate-2.0.pc
libmate_USE_MATE_IMPL=matevfs2 esound libbonobo

libbonoboui_LIB_DEPENDS=	bonoboui-2.0:${PORTSDIR}/x11-toolkits/libbonoboui
libbonoboui_DETECT=		${LOCALBASE}/libdata/pkgconfig/libbonoboui-2.0.pc
libbonoboui_USE_MATE_IMPL=	libmatecanvas libmate

libmateui_LIB_DEPENDS=		mateui-2.0:${PORTSDIR}/x11-toolkits/libmateui
libmateui_DETECT=		${LOCALBASE}/libdata/pkgconfig/libmateui-2.0.pc
libmateui_USE_MATE_IMPL=	libbonoboui

atspi_LIB_DEPENDS=	spi.10:${PORTSDIR}/accessibility/at-spi
atspi_DETECT=		${LOCALBASE}/libdata/pkgconfig/cspi-1.0.pc
atspi_USE_MATE_IMPL=	gtk20 libbonobo

libgailmate_DETECT=		${LOCALBASE}/libdata/pkgconfig/libgail-mate.pc
libgailmate_RUN_DEPENDS=	${libgailmate_DETECT}:${PORTSDIR}/x11-toolkits/libgail-mate
libgailmate_USE_MATE_IMPL=	libmateui atspi

libgtkhtml_LIB_DEPENDS=	gtkhtml-2.0:${PORTSDIR}/www/libgtkhtml
libgtkhtml_DETECT=	${LOCALBASE}/libdata/pkgconfig/libgtkhtml-2.0.pc
libgtkhtml_USE_MATE_IMPL=libxslt matevfs2

matedesktop_LIB_DEPENDS=	mate-desktop-2.17:${PORTSDIR}/x11/mate-desktop
matedesktop_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-desktop-2.0.pc
matedesktop_USE_MATE_IMPL=	gconf2 matedocutils pygtk2
matedesktop_MATE_DESKTOP_VERSION=2

matedesktopsharp20_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-desktop-sharp-2.0.pc
matedesktopsharp20_BUILD_DEPENDS=	${matedesktopsharp20_DETECT}:${PORTSDIR}/x11-toolkits/mate-desktop-sharp20
matedesktopsharp20_RUN_DEPENDS=	${matedesktopsharp20_DETECT}:${PORTSDIR}/x11-toolkits/mate-desktop-sharp20
matedesktopsharp20_USE_MATE_IMPL=	matesharp20 matepanel gtkhtml3 librsvg2 vte libmateprintui gtksourceview2 matepanel libwnck nautiluscdburner

libwnck_LIB_DEPENDS=	wnck-1.22:${PORTSDIR}/x11-toolkits/libwnck
libwnck_DETECT=		${LOCALBASE}/libdata/pkgconfig/libwnck-1.0.pc
libwnck_USE_MATE_IMPL=	gtk20

vte_LIB_DEPENDS=	vte.9:${PORTSDIR}/x11-toolkits/vte
vte_DETECT=		${LOCALBASE}/libdata/pkgconfig/vte.pc
vte_USE_MATE_IMPL=	gtk20

libzvt_LIB_DEPENDS=	zvt-2.0.0:${PORTSDIR}/x11-toolkits/libzvt
libzvt_DETECT=	${LOCALBASE}/libdata/pkgconfig/libzvt-2.0.pc
libzvt_USE_MATE_IMPL=	gtk20

librsvg2_LIB_DEPENDS=	rsvg-2.2:${PORTSDIR}/graphics/librsvg2
librsvg2_DETECT=	${LOCALBASE}/libdata/pkgconfig/librsvg-2.0.pc
librsvg2_USE_MATE_IMPL=libgsf gtk20

eel2_LIB_DEPENDS=	eel-2.2:${PORTSDIR}/x11-toolkits/eel
eel2_DETECT=		${LOCALBASE}/libdata/pkgconfig/eel-2.0.pc
eel2_USE_MATE_IMPL=	matedesktop

matepanel_LIB_DEPENDS=	panel-applet-3.0:${PORTSDIR}/x11/mate-panel
matepanel_DETECT=	${LOCALBASE}/libdata/pkgconfig/libpanelapplet-3.0.pc
matepanel_USE_MATE_IMPL=matedesktop libwnck matemenus matedocutils librsvg2
matepanel_MATE_DESKTOP_VERSION=2

nautilus2_LIB_DEPENDS=	nautilus-extension.1:${PORTSDIR}/x11-fm/nautilus
nautilus2_DETECT=	${LOCALBASE}/libdata/pkgconfig/libnautilus-extension.pc
nautilus2_USE_MATE_IMPL=librsvg2 matedesktop desktopfileutils gvfs
nautilus2_MATE_DESKTOP_VERSION=2

metacity_LIB_DEPENDS=	metacity-private.0:${PORTSDIR}/x11-wm/metacity
metacity_DETECT=	${LOCALBASE}/libdata/pkgconfig/libmetacity-private.pc
metacity_USE_MATE_IMPL=gconf2

gal2_LIB_DEPENDS=	gal-2.4.0:${PORTSDIR}/x11-toolkits/gal2
gal2_DETECT=		${LOCALBASE}/libdata/pkgconfig/gal-2.4.pc
gal2_USE_MATE_IMPL=mateui libmateprintui

matecontrolcenter2_LIB_DEPENDS=mate-window-settings.1:${PORTSDIR}/sysutils/mate-control-center
matecontrolcenter2_DETECT=${LOCALBASE}/libdata/pkgconfig/mate-window-settings-2.0.pc
matecontrolcenter2_USE_MATE_IMPL=metacity matemenus desktopfileutils libmatekbd matedesktop librsvg2

libgda2_LIB_DEPENDS=	gda-2.3:${PORTSDIR}/databases/libgda2
libgda2_DETECT=			${LOCALBASE}/libdata/pkgconfig/libgda.pc
libgda2_USE_MATE_IMPL=	glib20 libxslt

libgda3_LIB_DEPENDS=	gda-3.0.3:${PORTSDIR}/databases/libgda3
libgda3_DETECT=			${LOCALBASE}/libdata/pkgconfig/libgda-3.0.pc
libgda3_USE_MATE_IMPL=	glib20 libxslt

libgda4_LIB_DEPENDS=	gda-4.0.5:${PORTSDIR}/databases/libgda4
libgda4_DETECT=			 ${LOCALBASE}/libdata/pkgconfig/libgda-4.0.pc
libgda4_USE_MATE_IMPL=	glib20 libxslt

libmatedb_LIB_DEPENDS=	matedb-3.0.4:${PORTSDIR}/databases/libmatedb
libmatedb_DETECT=		${LOCALBASE}/libdata/pkgconfig/libmatedb.pc
libmatedb_USE_MATE_IMPL=libmateui libgda3

gtksourceview_LIB_DEPENDS=	gtksourceview-1.0.0:${PORTSDIR}/x11-toolkits/gtksourceview
gtksourceview_DETECT=	${LOCALBASE}/libdata/pkgconfig/gtksourceview-1.0.pc
gtksourceview_USE_MATE_IMPL=libmate libmateprintui

gtksourceview2_LIB_DEPENDS=	gtksourceview-2.0.0:${PORTSDIR}/x11-toolkits/gtksourceview2
gtksourceview2_DETECT=	${LOCALBASE}/libdata/pkgconfig/gtksourceview-2.0.pc
gtksourceview2_USE_MATE_IMPL=gtk20 libxml2

pkgconfig_DETECT=			${LOCALBASE}/bin/pkg-config
pkgconfig_BUILD_DEPENDS=	pkg-config:${PORTSDIR}/devel/pkg-config
pkgconfig_RUN_DEPENDS=		pkg-config:${PORTSDIR}/devel/pkg-config

libgsf_LIB_DEPENDS=			gsf-1.114:${PORTSDIR}/devel/libgsf
libgsf_DETECT=			${LOCALBASE}/libdata/pkgconfig/libgsf-1.pc
libgsf_USE_MATE_IMPL=		glib20 libxml2

libgsf_mate_LIB_DEPENDS=	gsf-mate-1.114:${PORTSDIR}/devel/libgsf-mate
libgsf_mate_DETECT=		${LOCALBASE}/libdata/pkgconfig/libgsf-mate-1.pc
libgsf_mate_USE_MATE_IMPL=	gconf2 libgsf matevfs2

pygobject_DETECT=		${LOCALBASE}/libdata/pkgconfig/pygobject-2.0.pc
pygobject_BUILD_DEPENDS=	pygobject-codegen-2.0:${PORTSDIR}/devel/py-gobject
pygobject_RUN_DEPENDS=		pygobject-codegen-2.0:${PORTSDIR}/devel/py-gobject
pygobject_USE_MATE_IMPL=	glib20

pygtk2_DETECT=			${LOCALBASE}/libdata/pkgconfig/pygtk-2.0.pc
pygtk2_BUILD_DEPENDS=	${pygtk2_DETECT}:${PORTSDIR}/x11-toolkits/py-gtk2
pygtk2_RUN_DEPENDS=		${pygtk2_DETECT}:${PORTSDIR}/x11-toolkits/py-gtk2
pygtk2_USE_MATE_IMPL=	libglade2 pygobject

pymate2_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-python-2.0.pc
pymate2_BUILD_DEPENDS=	${pymate2_DETECT}:${PORTSDIR}/x11-toolkits/py-mate2
pymate2_RUN_DEPENDS=	${pymate2_DETECT}:${PORTSDIR}/x11-toolkits/py-mate2
pymate2_USE_MATE_IMPL=libmateui pygtk2

intltool_DETECT=		${LOCALBASE}/bin/intltool-extract
intltool_BUILD_DEPENDS=	${intltool_DETECT}:${PORTSDIR}/textproc/intltool

intlhack_PRE_PATCH=		${FIND} ${WRKSRC} -name "intltool-merge.in" | ${XARGS} ${REINPLACE_CMD} -e \
				's|mkdir $$lang or|mkdir $$lang, 0777 or| ; \
				 s|^push @INC, "/.*|push @INC, "${LOCALBASE}/share/intltool";| ; \
				 s|/usr/bin/iconv|${LOCALBASE}/bin/iconv|g ; \
				 s|unpack *[(]'"'"'U\*'"'"'|unpack ('"'"'C*'"'"'|'
intlhack_USE_MATE_IMPL=intltool

gtkhtml3_LIB_DEPENDS=	gtkhtml-3.14.19:${PORTSDIR}/www/gtkhtml3
gtkhtml3_DETECT=		${LOCALBASE}/libdata/pkgconfig/libgtkhtml-3.14.pc
gtkhtml3_USE_MATE_IMPL=libglade2

matespeech_LIB_DEPENDS=matespeech.7:${PORTSDIR}/accessibility/mate-speech
matespeech_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-speech-1.0.pc
matespeech_USE_MATE_IMPL=libbonobo

evolutiondataserver_LIB_DEPENDS=edataserverui-1.2.11:${PORTSDIR}/databases/evolution-data-server
evolutiondataserver_DETECT=		${LOCALBASE}/libdata/pkgconfig/evolution-data-server-1.2.pc
evolutiondataserver_USE_MATE_IMPL=gconf2 libxml2

desktopfileutils_BUILD_DEPENDS=update-desktop-database:${PORTSDIR}/devel/desktop-file-utils
desktopfileutils_RUN_DEPENDS=update-desktop-database:${PORTSDIR}/devel/desktop-file-utils
desktopfileutils_DETECT=	${LOCALBASE}/bin/update-desktop-database
desktopfileutils_USE_MATE_IMPL=glib20

nautiluscdburner_LIB_DEPENDS=nautilus-burn.4:${PORTSDIR}/sysutils/nautilus-cd-burner
nautiluscdburner_DETECT=	${LOCALBASE}/libdata/pkgconfig/libnautilus-burn.pc
nautiluscdburner_USE_MATE_IMPL=nautilus2 desktopfileutils

matemenus_LIB_DEPENDS=		mate-menu.2:${PORTSDIR}/x11/mate-menus
matemenus_DETECT=			${LOCALBASE}/libdata/pkgconfig/libmate-menu.pc
matemenus_USE_MATE_IMPL=	glib20

pymateextras_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-python-extras-2.0.pc
pymateextras_BUILD_DEPENDS=	${pymateextras_DETECT}:${PORTSDIR}/x11-toolkits/py-mate-extras
pymateextras_RUN_DEPENDS=	${pymateextras_DETECT}:${PORTSDIR}/x11-toolkits/py-mate-extras
pymateextras_USE_MATE_IMPL=pymate2 libgtkhtml

matedocutils_DETECT=	${LOCALBASE}/libdata/pkgconfig/mate-doc-utils.pc
matedocutils_BUILD_DEPENDS=${matedocutils_DETECT}:${PORTSDIR}/textproc/mate-doc-utils
matedocutils_RUN_DEPENDS=${matedocutils_DETECT}:${PORTSDIR}/textproc/mate-doc-utils
matedocutils_USE_MATE_IMPL=libxslt

pymatedesktop_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-python-desktop-2.0.pc
pymatedesktop_BUILD_DEPENDS=	${pymatedesktop_DETECT}:${PORTSDIR}/x11-toolkits/py-mate-desktop
pymatedesktop_RUN_DEPENDS=	${pymatedesktop_DETECT}:${PORTSDIR}/x11-toolkits/py-mate-desktop
pymatedesktop_USE_MATE_IMPL=pymate2 libmateprintui gtksourceview matepanel libwnck nautilus2 metacity

gtksharp10_DETECT=			${LOCALBASE}/libdata/pkgconfig/gtk-sharp.pc
gtksharp10_BUILD_DEPENDS=	${gtksharp10_DETECT}:${PORTSDIR}/x11-toolkits/gtk-sharp10
gtksharp10_RUN_DEPENDS=		${gtksharp10_DETECT}:${PORTSDIR}/x11-toolkits/gtk-sharp10
gtksharp10_USE_MATE_IMPL=	gtk20

gtksharp20_DETECT=			${LOCALBASE}/libdata/pkgconfig/gtk-sharp-2.0.pc
gtksharp20_BUILD_DEPENDS=	${gtksharp20_DETECT}:${PORTSDIR}/x11-toolkits/gtk-sharp20
gtksharp20_RUN_DEPENDS=		${gtksharp20_DETECT}:${PORTSDIR}/x11-toolkits/gtk-sharp20
gtksharp20_USE_MATE_IMPL=	gtk20

matesharp20_DETECT=		${LOCALBASE}/libdata/pkgconfig/mate-sharp-2.0.pc
matesharp20_BUILD_DEPENDS=	${matesharp20_DETECT}:${PORTSDIR}/x11-toolkits/mate-sharp20
matesharp20_RUN_DEPENDS=	${matesharp20_DETECT}:${PORTSDIR}/x11-toolkits/mate-sharp20
matesharp20_USE_MATE_IMPL=	matepanel gtkhtml3 gtksharp20 librsvg2 vte

libmatekbd_DETECT=			${LOCALBASE}/libdata/pkgconfig/libmatekbd.pc
libmatekbd_LIB_DEPENDS=	matekbd.4:${PORTSDIR}/x11/libmatekbd
libmatekbd_USE_MATE_IMPL=	gconf2

pygtksourceview_DETECT=		${LOCALBASE}/libdata/pkgconfig/pygtksourceview-2.0.pc
pygtksourceview_BUILD_DEPENDS=	${pygtksourceview_DETECT}:${PORTSDIR}/x11-toolkits/py-gtksourceview
pygtksourceview_RUN_DEPENDS=	${pygtksourceview_DETECT}:${PORTSDIR}/x11-toolkits/py-gtksourceview
pygtksourceview_USE_MATE_IMPL=	gtksourceview2 pygtk2

gvfs_DETECT=			${LOCALBASE}/lib/libgvfscommon.so
gvfs_LIB_DEPENDS=		gvfscommon.0:${PORTSDIR}/devel/gvfs
gvfs_USE_MATE_IMPL=		glib20 gconf2

.if defined(MARCUSCOM_CVS)
. if exists(${PORTSDIR}/Mk/bsd.mate-experimental.mk)
.include "${PORTSDIR}/Mk/bsd.mate-experimental.mk"
. endif
.endif

.if defined(INSTALLS_ICONS)
USE_MATE+=	gtk-update-icon-cache
.endif

# End component definition section

# This section defines tests for optional software.  These work off four
# types of variables:  WANT_MATE, WITH_MATE, HAVE_MATE and USE_MATE.
# The logic of this is that a port can WANT support for a package; a user
# specifies if they want ports compiled WITH certain features; this section
# tests if we HAVE these features; and the port is then free to USE them.

# The logic of this section is like this:
#
# .if defined(WANT_MATE) && !defined(WITHOUT_MATE)
#   .for foo in ALL_MATE_COMPONENTS
#     .if defined(WITH_MATE)
#       HAVE_MATE += foo
#     .elif (foo installed)
#       HAVE_MATE += foo
#     .else
#       Print option message
#     .endif
#   .endfor
# .endif
#
# Although it appears a little more convoluted in the tests.

# Ports can make use of this like so:
#
# WANT_MATE=		yes
#
# .include <bsd.port.pre.mk>
#
# .if ${HAVE_MATE:Mfoo}!=""
# ... Do some things ...
# USE_MATE=		foo
# .else
# ... Do some other things ...
# .endif

# If the user has not defined MATE_DESKTOP_VERSION, let's try to prevent
# users from shooting themselves in the foot.  We will try to make an
# intelligent choice on the user's behalf.
.if exists(${matepanel3_DETECT})
MATE_DESKTOP_VERSION?=	3
.elif exists(${matepanel_DETECT})
MATE_DESKTOP_VERSION?=	2
.endif

# We also check each component to see if it has a desktop requirement.  If
# it does, and its requirement disagrees with the user's chosen desktop,
# do not add the component to the HAVE_MATE list.

_USE_MATE_SAVED:=${USE_MATE}
_USE_MATE_DESKTOP=yes
HAVE_MATE?=
.if (defined(WANT_MATE) && !defined(WITHOUT_MATE))
. for component in ${_USE_MATE_ALL}
.      if defined(MATE_DESKTOP_VERSION) && \
	defined(${component}_MATE_DESKTOP_VERSION)
.         if ${MATE_DESKTOP_VERSION}==${${component}_MATE_DESKTOP_VERSION}
HAVE_MATE+=	${component}
.         else
_USE_MATE_DESKTOP=no
.         endif
.      else
.         if exists(${${component}_DETECT})
HAVE_MATE+=	${component}
.         elif defined(WITH_MATE)
.            if ${WITH_MATE}=="yes" || ${WITH_MATE:M${component}}!="" \
		|| ${WITH_MATE}=="1"
HAVE_MATE+=	${component}
.            endif
.         endif
.       endif
. endfor
.elif defined(WITHOUT_MATE)
.  if ${WITHOUT_MATE}!="yes" && ${WITHOUT_MATE}!="1"
.    for component in ${_USE_MATE_ALL}
.      if ${WITHOUT_MATE:M${component}}==""
.        if exists(${${component}_DETECT})
HAVE_MATE+=	${component}
.        endif
.      endif
.    endfor
.  endif
.endif

.endif
# End of optional part.

.if defined(_POSTMKINCLUDED) && !defined(Gnome_Post_Include)

Gnome_Post_Include=		bsd.mate.mk

.if !defined(Gnome_Pre_Include)
.error The Pre include part of bsd.mate.mk part is not included. Did you forget WANT_MATE=yes before bsd.port.pre.mk?
.endif

.if defined(USE_MATE)
# First of all expand all USE_MATE_IMPL recursively
. for component in ${_USE_MATE_ALL}
.  for subcomponent in ${${component}_USE_MATE_IMPL}
${component}_USE_MATE_IMPL+=${${subcomponent}_USE_MATE_IMPL}
.  endfor
. endfor

# Then use already expanded USE_MATE_IMPL to expand USE_MATE.
# Also, check to see if each component has a desktop requirement.  If it does,
# and if the user's chosen desktop is not of the same version, mark the
# port as IGNORE.
. for component in ${USE_MATE:C/^([^:]+).*/\1/}
.      if defined(MATE_DESKTOP_VERSION) && \
	defined(${component}_MATE_DESKTOP_VERSION)
.         if ${MATE_DESKTOP_VERSION}!=${${component}_MATE_DESKTOP_VERSION}
IGNORE=	cannot install: ${PORTNAME} wants to use the MATE
IGNORE+=${${component}_MATE_DESKTOP_VERSION} desktop, but you wish to use
IGNORE+=the MATE ${MATE_DESKTOP_VERSION} desktop
.         endif
.      endif
.  if ${_USE_MATE_ALL:M${component}}==""
IGNORE=	cannot install: Unknown component ${component}
.  endif
_USE_MATE+=	${${component}_USE_MATE_IMPL} ${component}
. endfor

# Setup the GTK+ API version for pixbuf loaders, input method modules,
# and theme engines.
PLIST_SUB+=			GTK2_VERSION="${GTK2_VERSION}" \
				GTK3_VERSION="${GTK3_VERSION}"

# Then handle the ltverhack component (it has to be done here, because
# we rely on some bsd.autotools.mk variables, and bsd.autotools.mk is
# included in the post-makefile section).
.if defined(_AUTOTOOL_libtool)
lthacks_CONFIGURE_ENV=		ac_cv_path_DOLT_BASH=
lthacks_PRE_PATCH=		${CP} -pf ${LTMAIN} ${WRKDIR}/mate-ltmain.sh && \
						${CP} -pf ${LIBTOOL} ${WRKDIR}/mate-libtool && \
						for file in ${LIBTOOLFILES}; do \
							${REINPLACE_CMD} -e \
								'/^ltmain=/!s|$$ac_aux_dir/ltmain\.sh|${LIBTOOLFLAGS} ${WRKDIR}/mate-ltmain.sh|g; \
								 /^LIBTOOL=/s|$$(top_builddir)/libtool|${WRKDIR}/mate-libtool|g' \
								${PATCH_WRKSRC}/$$file; \
						done;
.else
.  if ${USE_MATE:Mltverhack*}!="" || ${USE_MATE:Mltasneededhack}!=""
IGNORE=	cannot install: ${PORTNAME} uses the ltverhack and/or ltasneededhack MATE components but does not use libtool
.  endif
.endif

.if ${USE_MATE:Mltverhack\:*:C/^[^:]+:([^:]+).*/\1/}==""
ltverhack_LIB_VERSION=	major=.`expr $$current - $$age`
.else
ltverhack_LIB_VERSION=	major=".${USE_MATE:Mltverhack\:*:C/^[^:]+:([^:]+).*/\1/}"
.endif
ltverhack_PATCH_DEPENDS=${LIBTOOL_DEPENDS}
ltverhack_PRE_PATCH=	for file in mate-ltmain.sh mate-libtool; do \
							if [ -f ${WRKDIR}/$$file ]; then \
								${REINPLACE_CMD} -e \
									'/freebsd-elf)/,/;;/ s|major="\.$$current"|${ltverhack_LIB_VERSION}|; \
									 /freebsd-elf)/,/;;/ s|versuffix="\.$$current"|versuffix="$$major"|' \
									${WRKDIR}/$$file; \
							fi; \
						done

ltasneededhack_PATCH_DEPENDS=${LIBTOOL_DEPENDS}
ltasneededhack_PRE_PATCH=	if [ -f ${WRKDIR}/mate-libtool ]; then \
								${REINPLACE_CMD} -e \
									'/^archive_cmds=/s/-shared/-shared -Wl,--as-needed/ ; \
									/^archive_expsym_cmds=/s/-shared/-shared -Wl,--as-needed/' \
									${WRKDIR}/mate-libtool; \
							fi

# Set USE_CSTD for all ports that depend on glib12
.if defined(_USE_MATE) && !empty(_USE_MATE:Mglib12)
USE_CSTD=	gnu89
.endif

# Then traverse through all components, check which of them
# exist in ${_USE_MATE} and set variables accordingly
.ifdef _USE_MATE
. if ${USE_MATE:Mltverhack*}!= "" || ${USE_MATE:Mltasneededhack}!= ""
MATE_PRE_PATCH+=	${lthacks_PRE_PATCH}
CONFIGURE_ENV+=		${lthacks_CONFIGURE_ENV}
. endif
. for component in ${_USE_MATE_ALL}
.  if ${_USE_MATE:M${component}}!=""
PATCH_DEPENDS+=	${${component}_PATCH_DEPENDS}
FETCH_DEPENDS+=	${${component}_FETCH_DEPENDS}
EXTRACT_DEPENDS+=${${component}_EXTRACT_DEPENDS}
BUILD_DEPENDS+=	${${component}_BUILD_DEPENDS}
.  if defined(MARCUSCOM_CVS)
.   if !defined(NODEPENDS)
LIB_DEPENDS+=	${${component}_LIB_DEPENDS}
RUN_DEPENDS+=	${${component}_RUN_DEPENDS}
.   endif
.  else
LIB_DEPENDS+=	${${component}_LIB_DEPENDS}
RUN_DEPENDS+=	${${component}_RUN_DEPENDS}
.  endif

CONFIGURE_ARGS+=${${component}_CONFIGURE_ARGS}
CONFIGURE_ENV+=	${${component}_CONFIGURE_ENV}
MAKE_ENV+=	${${component}_MAKE_ENV}

.    if !defined(CONFIGURE_TARGET) && defined(${component}_CONFIGURE_TARGET)
CONFIGURE_TARGET=	${${component}_CONFIGURE_TARGET}
.    endif

.    if defined(${component}_PRE_PATCH)
MATE_PRE_PATCH+=	; ${${component}_PRE_PATCH}
.    endif

.  endif
. endfor
.endif
.endif

.if defined(MATE_PRE_PATCH)

pre-patch: mate-pre-patch

mate-pre-patch:
	@${MATE_PRE_PATCH:C/^;//1}
.endif

.if defined(WANT_MATE)
USE_MATE?=
.  if ${_USE_MATE_SAVED}==${USE_MATE}
PLIST_SUB+=	MATE:="@comment " NOMATE:=""
.  else
PLIST_SUB+=	MATE:="" NOMATE:="@comment "
.    if defined(MATE_DESKTOP_VERSION)
.      if ${_USE_MATE_DESKTOP}=="yes"
PLIST_SUB+=	MATEDESKTOP:="" NOMATEDESKTOP:="@comment "
.      else
PLIST_SUB+=	MATEDESKTOP:="@comment " NOMATEDESKTOP:=""
.      endif
.    endif
.  endif
.endif

.if defined(USE_MATE_SUBR)
MATE_SUBR=		${LOCALBASE}/etc/mate.subr
RUN_DEPENDS+=	${MATE_SUBR}:${PORTSDIR}/sysutils/mate_subr
SUB_LIST+=		MATE_SUBR=${MATE_SUBR}
.endif

.if ${MAINTAINER}=="mate@FreeBSD.org"
CONFIGURE_FAIL_MESSAGE= "Please run the matelogalyzer, available from \"http://www.freebsd.org/mate/matelogalyzer.sh\", which will diagnose the problem and suggest a solution. If - and only if - the matelogalyzer cannot solve the problem, report the build failure to the FreeBSD MATE team at ${MAINTAINER}, and attach (a) \"${CONFIGURE_WRKSRC}/${CONFIGURE_LOG}\", (b) the output of the failed make command, and (c) the matelogalyzer output. Also, it might be a good idea to provide an overview of all packages installed on your system (i.e. an \`ls ${PKG_DBDIR}\`). Put your attachment up on any website, copy-and-paste into http://freebsd-mate.pastebin.com, or use send-pr(1) with the attachment. Try to avoid sending any attachments to the mailing list (${MAINTAINER}), because attachments sent to FreeBSD mailing lists are usually discarded by the mailing list software."
.endif


.if defined(GCONF_SCHEMAS) || defined(INSTALLS_OMF) || defined(INSTALLS_ICONS) \
	|| defined(GLIB_SCHEMAS) || (defined(_USE_MATE) && ${_USE_MATE:Mmatehier}!="")
pre-su-install: mate-pre-su-install
post-install: mate-post-install

mate-pre-su-install:
.if defined(_USE_MATE) && ${_USE_MATE:Mmatehier}!="" && !defined(NO_MTREE)
	@${MTREE_CMD} ${MTREE_ARGS:S/${MTREE_FILE}/${MATE_MTREE_FILE}/} ${PREFIX}/ >/dev/null
.endif
.if defined(GCONF_SCHEMAS)
	@${MKDIR} ${PREFIX}/etc/gconf/gconf.xml.defaults/
.else
	@${DO_NADA}
.endif

mate-post-install:
.  if defined(GCONF_SCHEMAS)
	@for i in ${GCONF_SCHEMAS}; do \
		${ECHO_CMD} "@unexec env GCONF_CONFIG_SOURCE=xml:${GCONF_CONFIG_OPTIONS}:%D/${GCONF_CONFIG_DIRECTORY} gconftool-2 --makefile-uninstall-rule %D/etc/gconf/schemas/$${i} > /dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
		${ECHO_CMD} "etc/gconf/schemas/$${i}" >> ${TMPPLIST}; \
		${ECHO_CMD} "@exec env GCONF_CONFIG_SOURCE=xml:${GCONF_CONFIG_OPTIONS}:%D/${GCONF_CONFIG_DIRECTORY} gconftool-2 --makefile-install-rule %D/etc/gconf/schemas/$${i} > /dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
	done
.  endif

# we put the @unexec behind the plist schema entry, because it compiles files 
# in the directory. So we should remove the port file first before recompiling.
.  if defined(GLIB_SCHEMAS)
	@for i in ${GLIB_SCHEMAS}; do \
		${ECHO_CMD} "share/glib-2.0/schemas/$${i}" >> ${TMPPLIST}; \
	done
	@${ECHO_CMD} "@exec glib-compile-schemas %D/share/glib-2.0/schemas > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST}; \
	${ECHO_CMD} "@unexec glib-compile-schemas --uninstall %D/share/glib-2.0/schemas > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST};
.endif

.  if defined(INSTALLS_OMF)
	@for i in `${GREP} "\.omf$$" ${TMPPLIST}`; do \
		${ECHO_CMD} "@exec scrollkeeper-install -q %D/$${i} 2>/dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
		${ECHO_CMD} "@unexec scrollkeeper-uninstall -q %D/$${i} 2>/dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
	done
.  endif

.  if defined(INSTALLS_ICONS)
	@${RM} -f ${TMPPLIST}.icons1
	@for i in `${GREP} "^share/icons/.*/" ${TMPPLIST} | ${CUT} -d / -f 1-3 | ${SORT} -u`; do \
		${ECHO_CMD} "@unexec /bin/rm %D/$${i}/icon-theme.cache 2>/dev/null || /usr/bin/true" \
			>> ${TMPPLIST}.icons1; \
		${ECHO_CMD} "@exec ${LOCALBASE}/bin/gtk-update-icon-cache -q -f %D/$${i} 2>/dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
		${ECHO_CMD} "@unexec ${LOCALBASE}/bin/gtk-update-icon-cache -q -f %D/$${i} 2>/dev/null || /usr/bin/true" \
			>> ${TMPPLIST}; \
		${LOCALBASE}/bin/gtk-update-icon-cache -q -f ${PREFIX}/$${i} 2>/dev/null || ${TRUE}; \
	done
	@if test -f ${TMPPLIST}.icons1; then \
		${CAT} ${TMPPLIST}.icons1 ${TMPPLIST} > ${TMPPLIST}.icons2; \
		${RM} -f ${TMPPLIST}.icons1; \
		${MV} -f ${TMPPLIST}.icons2 ${TMPPLIST}; \
	fi
.  endif
.endif

.endif
# End of use part.
