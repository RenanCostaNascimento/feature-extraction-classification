%Bases on the fileName, this function returns the emotion expressed on the
%audio file.
function emotion = extractEmotion(fileName)
    expression = '[A-Z]';
    emotionLetter = regexp(fileName, expression, 'match');
    emotionLetter = emotionLetter{1,1};
    
    switch emotionLetter
        case 'W'
            emotion = 'Anger';
        case 'L'
            emotion = 'Boredom';
        case 'E'
            emotion = 'Disgust';
        case 'A'
            emotion = 'Anxiety/Fear';
        case 'F'
            emotion = 'Happiness';
        case 'T'
            emotion = 'Sadness';
        otherwise
            emotion = 'Neutral';
    end