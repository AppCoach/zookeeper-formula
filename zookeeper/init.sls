{%- from 'zookeeper/settings.sls' import zk with context -%}

zookeeper:
  group.present:
    - gid: {{ zk.uid }}
  user.present:
    - uid: {{ zk.uid }}
    - gid: {{ zk.uid }}

zk-directories:
  file.directory:
    - user: zookeeper
    - group: zookeeper
    - mode: 755
    - makedirs: True
    - names:
      - {{ zk.data_dir }}
      - {{ zk.data_log_dir }}
      - {{ zk.real_home }}

install-zookeeper-dist:
  cmd.run:
    - name: curl -L '{{ zk.source_url }}' | tar xz --no-same-owner
    - cwd: {{ zk.prefix }}
    - unless: test -d {{ zk.real_home }}/lib
    - user: root
  alternatives.install:
    - name: zookeeper-home-link
    - link: {{ zk.alt_home }}
    - path: {{ zk.real_home }}
    - priority: 30
    - require:
      - cmd: install-zookeeper-dist
