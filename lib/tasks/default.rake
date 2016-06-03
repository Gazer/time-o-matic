Rake::Task['default'].prerequisites.clear
Rake::Task['default'].clear

task default: [:spec, :teaspoon]
