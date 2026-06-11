class Kolt < Formula
  desc "Lightweight build tool for Kotlin"
  homepage "https://github.com/snicmakino/kolt"
  url "https://github.com/snicmakino/kolt/releases/download/v0.26.0/kolt-0.26.0-macos-arm64.tar.gz"
  # Explicit because brew misreads the trailing "arm64" in the asset name as
  # the version ("64") when left to infer it from the url.
  version "0.26.0"
  sha256 "69bfa39d417fd4f22c358203e946fd7380e300b27d8f6260238721476caaceda"
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
