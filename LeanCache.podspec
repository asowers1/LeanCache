Pod::Spec.new do |spec|
	spec.name = "LeanCache"
	spec.version = "0.2.1"
	spec.summary = "A lean, mean, simple caching machine that's written in Swift"
	spec.homepage = "http://asowers.net/index.php/leancache"
	spec.license = { type: 'MIT', file: 'LICENSE' }
	spec.authors = { "Andrew Sowers" => "asow123@gmail.com" }
	spec.social_media_url = "http://twitter.com/andrewsowers"

	spec.platform = :ios, "9.0"
	spec.requires_arc = true
	spec.source = { git: "https://github.com/asowers1/LeanCache.git", tag: "#{spec.version}", submodules: true }
	spec.source_files = "LeanCache/**/*.{h,swift}"
end
