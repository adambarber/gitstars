describe 'Home' do
  it 'should have user search form', js: true do
    visit('/')
    expect(page).to have_content('FIGHT!')
  end

  it 'should render the right results for two users', js: true do
    visit('/')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[1]/input').set('adambarber')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[2]/input').set('jnunemaker')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[2]/div/button').click

    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div[1]/div/h2', text: 'ADAMBARBER')
    expect(find(:xpath, '//*[@id="container"]/div/div/div[2]/div[1]/div[1]/img')['src']).to eq 'https://avatars.githubusercontent.com/adambarber'

    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div[1]/div/div/div[1]', text: 'Total Stars: 8')
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div[1]/div/div/div[2]', text: 'Total Repos: 23')
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div[1]/div/div/div[3]', text: 'Average Stars: 0')

    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[1]/div/h2', text: 'JNUNEMAKER')
    expect(find(:xpath, '//*[@id="container"]/div/div/div[2]/div[2]/div[1]/img')['src']).to eq 'https://avatars.githubusercontent.com/jnunemaker'

    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[1]/div/div/div[1]', text: 'Total Stars: 7370')
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[1]/div/div/div[2]', text: 'Total Repos: 60')
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[1]/div/div/div[3]', text: 'Average Stars: 122')
  end

  it 'should declare the right winner', js: true do
    visit('/')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[1]/input').set('adambarber')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[2]/input').set('jnunemaker')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[2]/div/button').click

    expect(find(:xpath, '//*[@id="container"]/div/div/div[2]/div[2]')['class']).to eq "user-display winner"
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[1]/div[2]')
  end

  it 'should clear the username input when X is clicked', js: true do
    visit('/')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[1]/input').set('adambarber')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[1]/div').click
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[1]/form/div[1]/div[1]/input', text: '')

    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[2]/input').set('jnunemaker')
    find(:xpath, '//*[@id="container"]/div/div/div[1]/form/div[1]/div[2]/div').click
    expect(page).to have_xpath('//*[@id="container"]/div/div/div[1]/form/div[1]/div[2]/input', text: '')
  end
end