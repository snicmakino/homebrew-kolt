class Kolt < Formula
  desc "Lightweight build tool for Kotlin"
  homepage "https://github.com/snicmakino/kolt"
  url "https://github.com/snicmakino/kolt/releases/download/v0.25.0/kolt-0.25.0-macos-arm64.tar.gz"
  sha256 "df34a230d06b744fffa9dce4ad030617e395e2955b0c836478b27e9a05f9c39c"
  license "MIT"

  # The released binary loads /opt/homebrew/opt/{curl,libarchive} dylibs by
  # absolute install name (both are keg-only, macOS ships its own copies).
  depends_on "curl"
  depends_on "libarchive"
  depends_on arch: :arm64
  depends_on :macos

  def install
    # bin/kolt locates daemon jars via its own resolved path -> sibling
    # libexec/ tree, so the dist layout must land in the keg verbatim.
    prefix.install Dir["*"]
  end

  test do
    assert_match "kolt #{version}", shell_output("#{bin}/kolt --version")
  end
end
