# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION=" Symfony Finder Component"
HOMEPAGE="https://github.com/symfony/finder"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> symfony-finder-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
DEPEND="test? ( ${RDEPEND} >=dev-php/phpunit-5.7.15 )"

S="${WORKDIR}/finder-${PV}"

PATCHES=( "${FILESDIR}/skip-file-time-sort-tests.patch" )

src_prepare() {
	default
	if use test; then
		cp "${FILESDIR}/autoload.php" "${S}/autoload-test.php" || die
	fi
}

src_install() {
	insinto "/usr/share/php/Symfony/Component/Finder"
	doins -r Comparator Exception Iterator
	doins *.php "${FILESDIR}"/autoload.php
	dodoc CHANGELOG.md README.md
}

src_test() {
	phpunit --bootstrap "${S}/autoload-test.php" || die 'test suite failed'
}
