shared_examples 'profile::data_disk' do

  describe file('/data') do
    it do
      should be_mounted.with(
        :type    => 'xfs',
        :options => {
          :rw         => true,
          :noatime    => true,
          :nodiratime => true
        }
      )
    end
  end
end
