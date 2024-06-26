component "rubygem-semantic_puppet" do |pkg, settings, platform|
  # Projects may define a :rubygem_semantic_puppet_version setting, or we use 1.0.4 by default
  version = settings[:rubygem_semantic_puppet_version] || '1.1.0'
  if platform.is_cross_compiled? && platform.is_solaris?
    # solaris 10/11 sparc are failing in agent-runtime-7.x installing semantic_puppet because the gem requires ruby >= 2.7.0
    # when cross compiling on sparc, we use ancient pl-ruby or equivalen. For these older platforms, use older semantic_puppet
    version = '1.0.4'
  end
  pkg.version version

  case version
  when '0.1.2'
    pkg.md5sum '192ae7729997cb5d5364f64b99b13121'
  when '1.0.4'
    pkg.sha256sum "5d8380bf733c1552ef77e06a7c44a6d5b48def7d390ecf3bd71cad477f5ce13d"
  when '1.1.0'
    pkg.sha256sum "52d108d08e1a5d95c00343cb3a4936fb1deecff2be612ec39c9cb66be5a8b859"
  else
    raise "rubygem-semantic_puppet version #{version} has not been configured; Cannot continue."
  end

  instance_eval File.read('configs/components/_base-rubygem.rb')

  pkg.environment "GEM_HOME", (settings[:puppet_gem_vendor_dir] || settings[:gem_home])
end
