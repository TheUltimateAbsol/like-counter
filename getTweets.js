import { Rettiwt } from "rettiwt-api";

const API_KEY=process.env.API_KEY
const rettiwt = new Rettiwt({ apiKey: API_KEY});

function delay(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
  }

/**
 * Fetching the list of tweets that:
 * 	- are made by a user with username <username>,
 * 	- contain the words <word1> and <word2>
 */
// Fetching the details of the user whose username is <username>
// rettiwt.user.details('1140826190091116544')
// .then(details => {
// 	console.log(details)
// })
// .catch(error => {
//     console.error("error fetching details")
// })

async function getTweets(num){
	let tweets = []
	let found = 0
	let token = undefined
	let timeout = 0;
	while (found < num){
		try {
			const result = await rettiwt.tweet.search({ fromUsers: ['alkalinedd'] }, 20, token)
			console.error("Success pulling data")
			for (let i = 0; i < result.list.length && found < num; i++){
				tweets.push(result.list[i])
				found++
			}
			// Find next token
			if (!result.next) break
			token = result.next.value

			await delay(1000) // avoid api rate limit throttle
			timeout = 0
			console.error(found, "tweets found")
		} 
		catch (error) {
			console.error("error fetching details")
			console.log(error)
			// Back out if api rate limit is a failure
			if (timeout > 600)
				break
			// If temporarily throttled, wait
			if (error.response && error.response.status == 429){
				await delay(30000)
				timeout += 30
				continue
			}
			// Otherwise exit
			else {
				console.error(error)
				break
			}
		}
	}
	return tweets
}


// Gets user tweets that are not replies and do not contain media
console.log(await getTweets(100))
