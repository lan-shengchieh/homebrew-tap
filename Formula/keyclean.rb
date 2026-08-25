class Keyclean < Formula
  desc "Temporarily suppress macOS keyboard events while cleaning"
  homepage "https://github.com/lan-shengchieh/keyclean"
  url "https://github.com/lan-shengchieh/keyclean/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "4d87b4b09514ac76d98825f4c08fcfee165548bc067eef0f0c0c2ff7c746cd3d"
  license "MIT"
  head "https://github.com/lan-shengchieh/keyclean.git", branch: "main"

  depends_on macos: :ventura
  uses_from_macos "swift" => :build

  def install
    system "make", "bundle"
    bin.install "build/layout/bin/keyclean"
    libexec.install "build/layout/libexec/KeyClean.app"
    libexec.install "build/layout/libexec/KeyCleanFull.app"
  end

  test do
    app_version = shell_output(
      "/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' " \
      "#{libexec}/KeyClean.app/Contents/Info.plist",
    ).strip
    assert_equal version.to_s, app_version
    assert_match app_version, shell_output("#{bin}/keyclean --version")
    assert_match "Safe Mode", shell_output("#{bin}/keyclean --help")
    assert_match "--full-once", shell_output("#{bin}/keyclean --help")
    system "#{libexec}/KeyClean.app/Contents/MacOS/KeyClean", "--self-test"
    system "#{libexec}/KeyCleanFull.app/Contents/MacOS/KeyCleanFull", "--self-test"
    system "codesign", "--verify", "--deep", "--strict", libexec/"KeyClean.app"
    system "codesign", "--verify", "--deep", "--strict", libexec/"KeyCleanFull.app"
    assert_match "Control + Option + Command + U", shell_output("#{bin}/keyclean --help")
  end
end
