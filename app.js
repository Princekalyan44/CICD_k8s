const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('=================================');
console.log('Simple User Input Node.js App');
console.log('=================================\n');

function askQuestion() {
  rl.question('Enter your name (or type "exit" to quit): ', (name) => {
    if (name.toLowerCase() === 'exit') {
      console.log('\nThank you for using this application. Goodbye!');
      rl.close();
      return;
    }

    if (name.trim() === '') {
      console.log('Please enter a valid name.\n');
      askQuestion();
      return;
    }

    rl.question('Enter your age: ', (age) => {
      if (isNaN(age) || age.trim() === '') {
        console.log('Please enter a valid age.\n');
        askQuestion();
        return;
      }

      rl.question('Enter your city: ', (city) => {
        if (city.trim() === '') {
          console.log('Please enter a valid city.\n');
          askQuestion();
          return;
        }

        console.log('\n--- User Information ---');
        console.log(`Name: ${name}`);
        console.log(`Age: ${age}`);
        console.log(`City: ${city}`);
        console.log('------------------------\n');

        askQuestion();
      });
    });
  });
}

askQuestion();

rl.on('close', () => {
  process.exit(0);
});