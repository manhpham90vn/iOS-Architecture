.DEFAULT_GOAL := all

.PHONY: all
all: install generate

# install
.PHONY: install
install: installRuby installBundle installMint
installRuby:
	@sh scripts/ruby/install.sh
installBundle:
	bundle config path vendor/bundle
	bundle install --without=documentation --jobs 4 --retry 3
installMint:
	@sh scripts/mint/install.sh

# generate
.PHONY: generate
generate: generateResource installPod
generateResource:
	@sh scripts/mint/generateResource.sh
	@sh scripts/mint/generateProject.sh
installPod:
	bundle exec pod install

# test
.PHONY: xcodetest
xcodetest:
	xcodebuild \
	-workspace "My Project.xcworkspace" \
	-scheme "My Project" \
	-destination 'platform=iOS Simulator,name=iPhone 14 Pro' \
	-derivedDataPath "build" \
	-enableCodeCoverage YES \
	test \
	| bundle exec xcpretty -s -c

.PHONY: generateCoverage
generateCoverage: 
	bundle exec slather coverage

# delete
.PHONY: delete
delete: 
	rm -rf *.xcodeproj *.xcworkspace Pods/ Carthage/ Build/ Mints/ vendor/

# fastlane
.PHONY: setupCertificate
setupCertificate:
	bundle exec fastlane setup --env debug

.PHONY: runUnitTest
runUnitTest:
	bundle exec fastlane unittest --env debug

.PHONY: exportTestFlight
exportTestFlight:
	bundle exec fastlane export --env staging

.PHONY: open
open:
	xed .
