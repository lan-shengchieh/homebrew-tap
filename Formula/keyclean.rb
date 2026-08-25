class Keyclean < Formula
  desc "Temporarily suppress macOS keyboard events while cleaning"
  homepage "https://github.com/lan-shengchieh/keyclean"
  url "https://github.com/lan-shengchieh/keyclean/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "282b7e39962e35248c31816c367ca129f3ef3423bc49acc0f7f6fd96cbc9244b"
  license "MIT"
  head "https://github.com/lan-shengchieh/keyclean.git", branch: "main"

  depends_on macos: :ventura
  uses_from_macos "swift" => :build

  def install
    if File.exist?("Package.swift")
      system "make", "bundle"
      bin.install "build/layout/bin/keyclean"
      libexec.install "build/layout/libexec/KeyClean.app"
      libexec.install "build/layout/libexec/KeyCleanFull.app"
    else
      # Compatibility with the v0.1.0 source archive. Remove this branch once
      # the stable URL points at v0.2.0 or later.
      system "swiftc", "-O", "keyclean.swift", "-o", "keyclean"
      bin.install "keyclean"
    end
  end

  test do
    if (libexec/"KeyClean.app").exist?
      app_version = shell_output(
        "/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' " \
        "#{libexec}/KeyClean.app/Contents/Info.plist",
      ).strip
      assert_match app_version, shell_output("#{bin}/keyclean --version")
      assert_match "Safe Mode", shell_output("#{bin}/keyclean --help")
      assert_match "--full-once", shell_output("#{bin}/keyclean --help")
      system "#{libexec}/KeyClean.app/Contents/MacOS/KeyClean", "--self-test"
      system "#{libexec}/KeyCleanFull.app/Contents/MacOS/KeyCleanFull", "--self-test"
      system "codesign", "--verify", "--deep", "--strict", libexec/"KeyClean.app"
      system "codesign", "--verify", "--deep", "--strict", libexec/"KeyCleanFull.app"
    else
      assert_match version.to_s, shell_output("#{bin}/keyclean --version")
    end
    assert_match "Control + Option + Command + U", shell_output("#{bin}/keyclean --help")
  end
end
