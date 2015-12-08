require 'benchmark'

ATTRIBUTE_TYPES = {}.tap do |hash|
  50.times do |i|
    hash[i] = Struct
              .new(:searchable?)
              .new([true, false].sample)
  end
end

n = 100_000

Benchmark.bm do |x|

# code in master branch:
#       user     system      total        real
#   0.940000   0.010000   0.950000 (  0.945006)
  x.report do
    n.times do
      ATTRIBUTE_TYPES.select do |_, type|
        type.searchable?
      end.keys
    end
  end

# third (and current) suggested change:
#       user     system      total        real
#   0.620000   0.000000   0.620000 (  0.620670) 34.3% faster
  x.report do
    n.times do
      ATTRIBUTE_TYPES.keys.select! do |key|
        type = ATTRIBUTE_TYPES[key]
        type.searchable?
      end
    end
  end

# second suggested change:
#       user     system      total        real
#   0.560000   0.000000   0.560000 (  0.562692) 40.5% faster
  x.report do
    n.times do
      [].tap do |keys|
        ATTRIBUTE_TYPES.each do |key, type|
          keys << key if type.searchable?
        end
      end
    end
  end

# first suggested change:
#       user     system      total        real
#   0.880000   0.000000   0.880000 (  0.883534) 6.5% faster
  x.report do
    n.times do
      ATTRIBUTE_TYPES.each_with_object([]) do |(key, type), keys|
        keys << key if type.searchable?
      end
    end
  end
end