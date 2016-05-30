# -*- mode: puppet -*-
# vi: set ft=puppet
#
# === Authors
# Andreas Heumaier <andreas.heumaier@nordcloud.com>
#
class profile::web::tomcat (

  $catalina_base = '/opt/apache-tomcat/tomcat7',
  $tomcat_version = '8',
){

  $source_url = $tomcat_version ? {
    '7'     => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz',
    default => 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.2/bin/apache-tomcat-8.5.2.tar.gz'
  }

  unless defined(Package['epel-release']){
    package{  'epel-release':
      ensure  => 'installed',
    }
  }
  package{  'ruby-augeas':
    ensure  => 'installed',
    require => Package['epel-release']
  }

  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jre',
  } ->

  tomcat::instance { "tomcat${tomcat_version}":
    install_from_source => true,
    source_url          => $source_url,
    manage_user         => true,
    manage_group        => true,
    user                => 'tomcat',
    group               => 'tomcat',
    catalina_base       => $catalina_base,
    java_home           => '/usr/java/default',
  } ->
  tomcat::service { 'tomcat':
    catalina_base => $catalina_base,
    use_init      => false,
  }

  profile::register_profile{ 'tomcat': }

  file{'/opt/tomcat':
    ensure => 'link',
    target => $catalina_base
  }

}
