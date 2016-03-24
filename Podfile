platform :ios, '8.0'
use_frameworks!

target 'NetTime' do
  pod 'Appz', git: 'https://github.com/simonrice/Appz.git'
  pod 'Crashlytics', '~> 3.7'
  pod 'Fabric', '~> 1.6'
  pod 'Eureka', '~> 1.5'
  pod 'FontAwesome.swift', '~> 0.7'
  pod 'RxSwift', '~> 2.3'
  pod 'SwiftDate', '~> 3.0'
  pod 'SwiftyMarkdown', '~> 0.2'
end

target 'NetTimeWatch Extension' do
  platform :watchos, '2.0'

  pod 'RxSwift', '~> 2.3'
  pod 'SwiftDate', '~> 3.0'
end

target 'NetTimeTests' do
  pod 'Nimble', '~> 3.2'
  pod 'Quick', '~> 0.9'
  pod 'SwiftDate', '~> 3.0'
end

target 'NetTimeUITests' do
  pod 'Nimble', '~> 3.2'
  pod 'SimulatorStatusMagic', git: 'https://github.com/openium/SimulatorStatusMagic.git'
end

target 'TodayExtension' do
  pod 'RxSwift', '~> 2.3'
  pod 'SwiftDate', '~> 3.0'
end

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-NetTime/Pods-NetTime-acknowledgements.markdown', 'NetTime/Resources/Acknowledgements.md', remove_destination: true)
end
