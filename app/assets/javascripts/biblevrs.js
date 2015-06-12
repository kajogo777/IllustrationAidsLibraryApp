
 $(document).ready(function(){

quotes = new Array(18);
authors = new Array(18);
quotes[0] = "And we know that all things work together for good to them that love God, to them who are called according to his purpose.";
authors[0] = "Romans 8:28";
quotes[1] = "Do all things without murmurings and disputings.";
authors[1] = "Philippians 2:14";
quotes[2] = "But godliness with contentment is great gain.";
authors[2] = "1 Timothy 6:6";
quotes[3] = "Though wilt show me the path of life. In thy presence is fullness of joy. At thy right hand there are pleasures forevermore.";
authors[3] = "Psalm 16:11";
quotes[4] = "For God so loved the world that He gave His only begotten son, that whosoever believeth in Him should not perish but have everlasting life.";
authors[4] = "John 3:16";
quotes[5] = "Whatsoever things are true, whatsoever things are honest, whatsoever things are just whatsoever things are pure, whatsoever things are lovely, whatsoever things are of good report; if there be any virtue and if there be any praise, think on these things.";
authors[5] = "Philippians 4:8";
quotes[6] = "Be still and know that I am God.";
authors[6] = "Psalm 46:10";
quotes[7] = "Study to shew thyself approved unto God, a workman that needeth not to be ashamed, rightly dividing the word of truth.";
authors[7] = "2 Timothy 2:15";
quotes[8] = "Let us therefore come boldly unto the throne of grace, that we may obtain mercy, and find grace to help in time of need.";
authors[8] = "Hebrews 4:16";
quotes[9] = "When thou passest through the waters, I will be with thee; and through the rivers, they shall not overflow thee; when thou walkest through the fire, thou shalt not be burned; neither shall the flame kindle upon thee.";
authors[9] = "Isaiah 43:2";
quotes[10] = "I am crucified with Christ: nevertheless I live; yet not I, but Christ liveth in me: and the life which I now live in the flesh I live by the faith of the Son of God, who loved me and gave Himself for me.";
authors[10] = "Galatians 2:20";
quotes[11] = "Let nothing be done through strife or vain glory but in lowliness of mind let each esteem other better than themselves.";
authors[11] = "Philippians 2:3";
quotes[12] = "But my God shall supply all your needs according to his riches in glory by Christ Jesus.";
authors[12] = "Philippians 4:19";
quotes[13] = "Wait on the Lord: be of good courage, and He shall strengthen thine heart: wait, I say, on the Lord.";
authors[13] = "Psalm 27:14";
quotes[14] = "Know ye that the Lord He is God: it is He that hath made us, and not we ourselves; we are his people, and the sheep of His pasture.";
authors[14] = "Psalm 100:3";
quotes[15] = "Fear thou not; for I am with thee: be not dismayed; for I am thy God: I will strengthen thee; yea, I will help thee; yea, I will uphold thee with the right hand of my righteousness.";
authors[15] = "Isaiah 41:10";
quotes[16] = "Yet I say unto you, that even Solomon in all his glory was not arrayed like one of these.";
authors[16] = "Matthew 6:29";
quotes[17] = "The LORD is good, a strong hold in the day of trouble; and he knoweth them that trust in Him.";
authors[17] = "Nahum 1:7";

index = Math.floor(Math.random() * quotes.length);

$("#verse").text(quotes[index]);
$("#author").text(authors[index]);

});