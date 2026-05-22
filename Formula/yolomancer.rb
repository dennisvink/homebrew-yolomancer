class Yolomancer < Formula
  desc "Agentic coding CLI for yolomancer"
  homepage "https://github.com/dennisvink/yolomancer"
  version "0.1.6"
  license "MIT"

  release_tag = "v#{version}"

  on_macos do
    on_arm do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-darwin-arm64-#{version}"
      sha256 "b801a19ef853d7b1c4fcfc8a5ce8be67da11317fab2d76f9d03a52c07aa91c55"
    end

    on_intel do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-darwin-amd64-#{version}"
      sha256 "8cff26d5bf4aa66c478a1914fcb5337d05085f559164a5942744ec882fa72133"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-linux-amd64-#{version}"
      sha256 "ae2cfcbb88fa163575028e4f0c535be64a611c1d942af00cc0c16343d1fb83fc"
    end

    on_arm do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-linux-arm64-#{version}"
      sha256 "6140376a714d27bbac79596b36295e81b13fbc00c94f4ed96f0f1170ae216b61"
    end
  end

  def install
    binary_name =
      if OS.mac?
        Hardware::CPU.arm? ? "yolomancer-darwin-arm64-#{version}" : "yolomancer-darwin-amd64-#{version}"
      elsif OS.linux?
        Hardware::CPU.arm? ? "yolomancer-linux-arm64-#{version}" : "yolomancer-linux-amd64-#{version}"
      else
        odie "Unsupported platform for yolomancer"
      end

    source_binary = buildpath/binary_name
    odie "Expected prebuilt binary missing: #{source_binary}" unless source_binary.exist?

    bin.install source_binary => "yolomancer"
    chmod 0755, bin/"yolomancer"
  end

  test do
    assert_match "Agentic coding CLI for yolomancer", shell_output("#{bin}/yolomancer --help")
  end
end
